require 'spec_helper'

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

describe CaseLogsController, :type => :controller  do

  # This should return the minimal set of attributes required to create a valid
  # CaseLog. As you add validations to CaseLog, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "patient_name" => "someone", "title" => "some title" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CaseLogsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    @user = FactoryGirl.build(:doctor, admin: true)
    CaseLogsController.any_instance.stub(:current_user).and_return @user
    Permission.any_instance.stub(:allow?).and_return true
  end

  describe "GET index" do
    it "assigns all case_logs as @case_logs" do
      case_log = CaseLog.create! valid_attributes
      get :index, {}, valid_session
      assigns(:case_logs).should eq([case_log])
    end
  end

  describe "GET show" do
    it "assigns the requested case_log as @case_log" do
      case_log = CaseLog.create! valid_attributes
      get :show, {:id => case_log.to_param}, valid_session
      assigns(:case_log).should eq(case_log)
    end

  end

  describe "GET new" do
    it "assigns a new case_log as @case_log" do
      get :new, {}, valid_session
      assigns(:case_log).should be_a_new(CaseLog)
    end
  end

  describe "GET edit" do
    it "assigns the requested case_log as @case_log" do
      case_log = CaseLog.create! valid_attributes
      get :edit, {:id => case_log.to_param}, valid_session
      assigns(:case_log).should eq(case_log)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CaseLog" do
        expect {
          post :create, {:case_log => valid_attributes}, valid_session
        }.to change(CaseLog, :count).by(1)
      end

      it "assigns a newly created case_log as @case_log" do
        post :create, {:case_log => valid_attributes}, valid_session
        assigns(:case_log).should be_a(CaseLog)
        assigns(:case_log).should be_persisted
      end

      it "redirects to the created case_log" do
        post :create, {:case_log => valid_attributes}, valid_session
        response.should redirect_to(CaseLog.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved case_log as @case_log" do
        # Trigger the behavior that occurs when invalid params are submitted
        CaseLog.any_instance.stub(:save).and_return(false)
        post :create, {:case_log => { "patient_name" => "invalid value" }}, valid_session
        assigns(:case_log).should be_a_new(CaseLog)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CaseLog.any_instance.stub(:save).and_return(false)
        post :create, {:case_log => { "patient_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested case_log" do
        case_log = CaseLog.create! valid_attributes
        # Assuming there are no other case_logs in the database, this
        # specifies that the CaseLog created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CaseLog.any_instance.should_receive(:update).with({ "patient_name" => "MyString" })
        put :update, {:id => case_log.to_param, :case_log => { "patient_name" => "MyString" }}, valid_session
      end

      it "assigns the requested case_log as @case_log" do
        case_log = CaseLog.create! valid_attributes
        put :update, {:id => case_log.to_param, :case_log => valid_attributes}, valid_session
        assigns(:case_log).should eq(case_log)
      end

      it "redirects to the case_log" do
        case_log = CaseLog.create! valid_attributes
        put :update, {:id => case_log.to_param, :case_log => valid_attributes}, valid_session
        response.should redirect_to(case_log)
      end
    end

    describe "with invalid params" do
      it "assigns the case_log as @case_log" do
        case_log = CaseLog.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CaseLog.any_instance.stub(:save).and_return(false)
        put :update, {:id => case_log.to_param, :case_log => { "patient_name" => "invalid value" }}, valid_session
        assigns(:case_log).should eq(case_log)
      end

      it "re-renders the 'edit' template" do
        case_log = CaseLog.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CaseLog.any_instance.stub(:save).and_return(false)
        put :update, {:id => case_log.to_param, :case_log => { "patient_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested case_log" do
      case_log = CaseLog.create! valid_attributes
      expect {
        delete :destroy, {:id => case_log.to_param}, valid_session
      }.to change(CaseLog, :count).by(-1)
    end

    it "redirects to the case_logs list" do
      case_log = CaseLog.create! valid_attributes
      delete :destroy, {:id => case_log.to_param}, valid_session
      response.should redirect_to(case_logs_path)
    end
  end

end
