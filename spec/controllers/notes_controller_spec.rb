require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe NotesController, type: :controller do
  let(:report)  { FactoryBot.create :report }
  let(:project) { report.project }
  let(:organization) { project.organization }

  # This should return the minimal set of attributes required to create a valid
  # Note. As you add validations to Note, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:note)
  }

  let(:invalid_attributes) {
    { title: nil }
  }

  let(:base_params) {
    {
      organization_id: organization.to_param,
      project_id: project.id,
      report_id: report.to_param
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NotesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      report.notes.create! valid_attributes
      get :index, params: base_params.merge({}), session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      note = report.notes.create! valid_attributes
      get :show, params: base_params.merge({id: note.to_param}), session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Note" do
        expect {
          post :create, params: base_params.merge({note: valid_attributes}), session: valid_session
        }.to change(report.notes, :count).by(1)
      end

      it "renders a JSON response with the new note" do

        post :create, params: base_params.merge({note: valid_attributes}), session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response.location).to eq(organization_project_report_note_url(organization.to_param, project, report.to_param, report.notes.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new note" do

        post :create, params: base_params.merge({note: invalid_attributes}), session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:note)
      }

      it "updates the requested note" do
        note = report.notes.create! valid_attributes
        put :update, params: base_params.merge({id: note.to_param, note: new_attributes}), session: valid_session
        note.reload
        expect(note.title).to eql(new_attributes[:title])
      end

      it "renders a JSON response with the note" do
        note = report.notes.create! valid_attributes

        put :update, params: base_params.merge({id: note.to_param, note: valid_attributes}), session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the note" do
        note = report.notes.create! valid_attributes

        put :update, params: base_params.merge({id: note.to_param, note: invalid_attributes}), session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested note" do
      note = report.notes.create! valid_attributes
      expect {
        delete :destroy, params: base_params.merge({id: note.to_param}), session: valid_session
      }.to change(report.notes, :count).by(-1)
    end
  end

end
