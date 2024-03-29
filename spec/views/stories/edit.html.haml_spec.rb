require 'spec_helper'

describe "stories/edit" do
  before(:each) do
    @story = assign(:story, stub_model(Story,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stories_path(@story), :method => "post" do
      assert_select "input#story_name", :name => "story[name]"
      assert_select "textarea#story_description", :name => "story[description]"
    end
  end
end
