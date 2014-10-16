require 'spec_helper'

describe "Ideas" do
  before :each do
      @idea = Idea.create title: "Perfect Idea", body: "something"
  end

  describe "GET /ideas" do
    it "displays a list of ideas" do
      visit ideas_path
      page.should have_content "Perfect Idea"
    end
  end

  describe "POST /ideas" do
    it "creates a new idea" do
      visit ideas_path
      click_link "New Idea"
      current_path.should eq new_idea_path
      fill_in "Title", with: "new idea"
      fill_in "Body", with: "new body"
      click_button "Create Idea"
      current_path.should eq ideas_path
      page.should have_content "new idea"
    end

    it "does not create a new idea with empty title" do
      visit ideas_path
      click_link "New Idea"
      fill_in "Title", with: ""
      fill_in "Body", with: "new body"
      click_button "Create Idea"
      current_path.should eq new_idea_path
      page.should have_content "Unable to create new idea."
    end
  end

  describe "PUT /ideas" do
    it "updates an idea" do
      visit ideas_path
      click_link "Perfect Idea"
      click_link "Edit"
      fill_in "Title", with: "Super Perfect Idea"
      click_button "Update Idea"
      current_path.should eq idea_path(@idea)
      page.should have_content "Super Perfect Idea"
    end
    it "does not update an idea w/o a title" do
      visit ideas_path
      click_link "Perfect Idea"
      click_link "Edit"
      fill_in "Title", with: ""
      click_button "Update Idea"
      current_path.should eq edit_idea_path(@idea)
      page.should have_content "Unable to update idea."
    end

  end

  #############
  # delete on the front page? probably not
  describe "DELETE /ideas" do
    pending "deletes an idea" do
      visit ideas_path
      click_link "Delete"
      current_path.should eq ideas_path
      page.should have_no_content ""
      page.should have_content "Idea deleted."
    end
  end
end
