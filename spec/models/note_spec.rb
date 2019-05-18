require 'rails_helper'

RSpec.describe Note, type: :model do

  before do 
    @user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    @project = @user.projects.create(
      name: "Test project",
    )
  end

  # ユーザー、プロジェクト、メッセージがあれば有効な状態であること
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note.",
      user: @user,
      project: @project,
      )

      expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it "is invalid without a message" do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "search message for a term" do

    before do
    @note1 = @project.notes.create(
      message: "This is first note",
      user: @user,
    )

    @note2 = @project.notes.create(
      message: 'This is second note',
      user: @user,
    )

    @note3 = @project.notes.create(
      message: 'First, present the oven',
      user: @user,
    )
  end

      context "when a match is found" do
        it "returns notes that match the search term" do
          expect(Note.search("first")).to include(@note1, @note3)
        end
      end

      context "when no match is found" do
        it "returns an empty collection" do
          expect(Note.search("first")).to_not include(@note2)
        end
      end
  end
end
