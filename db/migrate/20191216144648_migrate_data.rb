require 'tty-progressbar'

class MigrateData < ActiveRecord::Migration[6.0]
  def up
    #=============================================================#
    #               O R G A N I Z A T I O N                       #
    #=============================================================#
    add_column :annotable_organizations, :legacy_id, :bigint

    sql   = 'SELECT COUNT(*) FROM organizations'
    total = select_value(sql)
    bar   = TTY::ProgressBar.new("progressing [:bar]", total: total)

    say_with_time("migrate #{total}x organizations") do
      select_all('SELECT * FROM organizations').each do |organization_attributes|
        bar.advance(1)

        legacy_id  = organization_attributes.delete('id')
        updated_at = organization_attributes.delete('updated_at')
        created_at = organization_attributes.delete('created_at')

        migrated_organization = Annotable::Organization.create!(organization_attributes)
        migrated_organization.update_columns(created_at: created_at, updated_at: updated_at, legacy_id: legacy_id)
      end

      organizations_id_seq_value = select_value("SELECT NEXTVAL('organizations_id_seq')")

      sql = <<-SQL.squish
        CREATE SEQUENCE public.annotable_organizations_legacy_id_seq
            START WITH #{organizations_id_seq_value}
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
      SQL
      execute(sql)

      sql = 'ALTER SEQUENCE public.annotable_organizations_legacy_id_seq OWNED BY public.annotable_organizations.legacy_id'
      execute(sql)

      sql = <<-SQL.squish
        ALTER TABLE ONLY public.annotable_organizations
        ALTER COLUMN legacy_id SET DEFAULT nextval('public.annotable_organizations_legacy_id_seq'::regclass)
      SQL
      execute(sql)

      sql = <<-SQL.squish
        ALTER TABLE annotable_organizations ADD CONSTRAINT annotable_organizations_legacy_id_uniq UNIQUE (legacy_id)
      SQL
      execute(sql)

      remove_foreign_key :projects, :organizations

      sql = <<-SQL.squish
        ALTER TABLE ONLY public.projects
          ADD CONSTRAINT fk_projects_organization_id FOREIGN KEY (organization_id) REFERENCES public.annotable_organizations(legacy_id)
      SQL
      execute(sql)

      change_column_null(:annotable_organizations, :legacy_id, false)
    end

    #=============================================================#
    #                       U S E R                               #
    #=============================================================#
    add_column :annotable_users, :legacy_id, :bigint

    sql   = 'SELECT COUNT(*) FROM users'
    total = select_value(sql)
    bar   = TTY::ProgressBar.new("progressing [:bar]", total: total)

    say_with_time("migrate #{total}x users") do
      select_all('SELECT * FROM users').each do |user_attributes|
        bar.advance(1)

        legacy_id       = user_attributes.delete('id')
        updated_at      = user_attributes.delete('updated_at')
        created_at      = user_attributes.delete('created_at')
        organization_id = user_attributes.delete('organization_id')

        if organization_id
          ActiveRecord::Migration.suppress_messages do
            organization_id = select_value("SELECT id FROM annotable_organizations WHERE legacy_id = #{organization_id}")
            user_attributes.merge!(organization_id: organization_id)
          end
        end

        migrated_user = Annotable::User.create!(user_attributes)
        migrated_user.update_columns(created_at: created_at, updated_at: updated_at, legacy_id: legacy_id)
      end

      users_id_seq_value = select_value("SELECT NEXTVAL('users_id_seq')")

      sql = <<-SQL.squish
        CREATE SEQUENCE public.annotable_users_legacy_id_seq
            START WITH #{users_id_seq_value}
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
      SQL
      execute(sql)

      sql = 'ALTER SEQUENCE public.annotable_users_legacy_id_seq OWNED BY public.annotable_users.legacy_id'
      execute(sql)

      sql = <<-SQL.squish
        ALTER TABLE ONLY public.annotable_users
        ALTER COLUMN legacy_id SET DEFAULT nextval('public.annotable_users_legacy_id_seq'::regclass)
      SQL
      execute(sql)

      sql = <<-SQL.squish
        ALTER TABLE annotable_users ADD CONSTRAINT annotable_users_legacy_id_uniq UNIQUE (legacy_id)
      SQL
      execute(sql)

      change_column_null(:annotable_users, :legacy_id, false)
    end

    #=============================================================#
    #                      R E P O R T                            #
    #=============================================================#
    add_column :annotable_reports, :project_id, :bigint
    add_foreign_key :annotable_reports, :projects

    add_column :annotable_reports, :legacy_id, :bigint

    sql   = 'SELECT COUNT(*) FROM reports'
    total = select_value(sql)
    bar   = TTY::ProgressBar.new("progressing [:bar]", total: total)

    say_with_time("migrate #{total}x reports") do
      sql = <<-SQL.squish
        SELECT reports.*, annotable_organizations.id AS organization_id FROM reports
          JOIN projects ON projects.id = reports.project_id
          JOIN annotable_organizations ON annotable_organizations.legacy_id = projects.organization_id
      SQL
      select_all(sql).each do |report_attributes|
        bar.advance(1)

        legacy_id  = report_attributes.delete('id')
        updated_at = report_attributes.delete('updated_at')
        created_at = report_attributes.delete('created_at')

        migrated_report = Annotable::Report.create!(report_attributes)
        migrated_report.update_columns(created_at: created_at, updated_at: updated_at, legacy_id: legacy_id)
      end

      reports_id_seq_value = select_value("SELECT NEXTVAL('reports_id_seq')")

      sql = <<-SQL.squish
        CREATE SEQUENCE public.annotable_reports_legacy_id_seq
            START WITH #{reports_id_seq_value}
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
      SQL
      execute(sql)

      sql = 'ALTER SEQUENCE public.annotable_reports_legacy_id_seq OWNED BY public.annotable_reports.legacy_id'
      execute(sql)

      sql = <<-SQL.squish
        ALTER TABLE ONLY public.annotable_reports
          ALTER COLUMN legacy_id SET DEFAULT nextval('public.annotable_reports_legacy_id_seq'::regclass)
      SQL
      execute(sql)

      sql = <<-SQL.squish
        ALTER TABLE annotable_reports ADD CONSTRAINT annotable_reports_legacy_id_uniq UNIQUE (legacy_id)
      SQL
      execute(sql)

      change_column_null(:annotable_reports, :legacy_id, false)
    end

    #=============================================================#
    #                         N O T E                             #
    #=============================================================#
    remove_foreign_key :notes, :reports

    sql = <<-SQL.squish
      ALTER TABLE ONLY public.notes
        ADD CONSTRAINT fk_notes_report_id FOREIGN KEY (report_id) REFERENCES public.annotable_reports(legacy_id)
    SQL
    execute(sql)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
