require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  # before do
  #   @user = FactoryBot.create(:user)
  #   project = FactoryBot.create(:project, owner: @user)
  #   @task = project.tasks.create!(name: "Test task")
  # end
  # let(:user){FactoryBot.create(:user)}
  # let(:project){FactoryBot.create(:project, owner: user)}
  # let(:task){project.tasks.create!(name: "Task task")}
  include_context "project setup"

  describe "#show" do
    it "responds with JSON formatted output" do
      sign_in user
      get :show, format: :json,
        params: { project_id: project.id, id: task.id }
      expect(response).to have_content_type :json
    end
  end

  describe "#create" do
    it "responds with JSON formatted output" do
      new_task = { name: "New test task" }
      sign_in user
      post :create, format: :json,
        params: { project_id: project.id, task: new_task }
      expect(response).to have_content_type :json
    end

    it "adds a new task to the project" do
      new_task = { name: "New test task" }
      sign_in user
      expect {
        post :create, format: :json,
          params: { project_id: project.id, task: new_task }
      }.to change(project.tasks, :count).by(1)
    end

    it "requires authentication" do
      new_task = { name: "New test task" }
      # Don't sign in this time ...
      expect {
        post :create, format: :json,
          params: { project_id: project.id, task: new_task }
      }.to_not change(project.tasks, :count)
      expect(response).to_not be_success
    end
  end
end
