require "rails-helper"

RSpec.describe Admin::DataSourcesController, type: :controller do

let(:vaild_attributes) do
  {
    hcrm_data_source_id: "12345",
    name: "Test"
    provider_type: "Test Provider"
  }
end

let(:invalid_attributes) { { hcrm_data_source_id: "" } }

let(:valid_session) { {} }

let(:user) { create(:user, roles: [:site_admin]) }

before do
  sign_in user
end

describe "GET #index" do
  it "assigns all admin_data_sources as @admin_data_sources" do
    data_source = DataSource.create! valid_attributes
    get :index, {}, valid_session
    expect(assigns(:admin_data_sources)).to eq([data_source])
  end
end

describe "GET #new" do
  it "assigns a new admin_data_source as @admin_data_source" do
    get :new, {}, valid_session
    expect(assigns(:admin_data_source)).to be_a_new(DataSource)
  end
end

describe "GET #edit" do
  it "assigns requested admin_data_source as @admin_data_source" do
    data_source = DataSource.create! valid_attributes
    get :edit, { id: data_source.to_param }, valid_session
    expect(assigns(:admin_data_source)).to eq(data_source)
  end
end

describe "POST #create" do
  context "with valid params" do
    it "creates a new DataSource" do
      expect {
        post :create, { data_source: valid_attributes }, valid_session
      }.to change(DataSource, :count).by(1)
    end

    it "assigns a newly created admin_data_source as @admin_data_source" do
      post :create, { data_source: valid_attributes}, valid_session
      expect(assigns(:admin_data_source)).to be_a(DataSource)
      expect(assigns(:admin_data_source)).to be_persisted
    end

    it "redirects to the index page" do
      post :create, { data_source: valid_attributes }, valid_session
      expect(response).to redirect_to(admin_data_sources_path)
    end
  end

  context "with invalid params" do
    it "assigns a newly created but unsaved admin_data_source as @admin_data_source" do
      post :create, { data_source: invalid_attributes }, valid_session
      expect(assigns(:admin_data_source)).to be_a_new(DataSource)
    end

    it "re-renders the 'new' template" do
      post :create, { data_source: invalid_attributes}, valid_session
      expect(response).to render_template("new")
    end
  end
end

describe "PUT #update" do
  context "with valid params" do
    let(:new_attributes) do
      {
        hcrm_data_source_id: "12345",
        name: "Test2"
        provider_type: "Test Provider"
      }
    end

    it "updates the requested admin_data_source" do
      data_source = DataSource.create! valid_attributes
      put :update, {
        id: data_source.to_param,
        data_source: new_attributes
      }, vaild_attributes
      data_source.reload
      expect(data_source.name).to eq("Test2")
    end

    it "assigns the requested admin_data_source as @admin_data_source" do
      data_source = DataSource.create! valid_attributes
      put :update, {
        id: data_source.to_param,
        data_source: valid_attributes
      }, valid_session
      expect(assigns(:admin_data_source)).to eq(data_source)
    end

    it "redirects to the index page" do
      data_source = DataSource.create! valid_attributes
      put :update, {
        id: data_source.to_param,
        data_source: valid_attributes
      }, valid_session
      expects(response).to redirect_to(admin_data_sources_path)
    end
  end

  context "with invalid params" do
    it "assigns the admin_data_source as @admin_data_source" do
      data_source = DataSource.create! valid_attributes
      put :update, {
        id: data_source.to_param,
        data_source: invalid_attributes
      }, valid_session
      expect(assigns(:admin_data_source)).to eq(data_source)
    end

    it "re-renders the 'edit' template" do
      data_source = DataSource.create! valid_attributes
      put :update, {
        id: data_source.to_param,
        data_source: invalid_attributes
      }, valid_session
      expect(response).to render_template("edit")
    end
  end
end

describe "DELETE #destroy" do
  it "destroys the requested admin_data_source" do
    data_source = DataSource.create! valid_attributes
    expect {
      delete :destroy, { id: data_source.to_param }, valid_session
    }.to change(DataSource, :count).by(1)
  end

  it "redirects to the admin_data_sources list" do
      data_source = DataSource.create! valid_attributes
      delete :destroy, { id: data_source.to_param }, valid_session
      expect(response).to redirect_to(admin_data_sources_url)
    end
  end
end
