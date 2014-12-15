require 'spec_helper'
describe Image do

  let(:valid_attributes) { { "url" => "MyString", "title" => "image1" } }
	before :each do
	  Permission.any_instance.stub(:allow?).and_return true
	  UrlValidator.any_instance.stub(:validate_each).and_return true
	end

  it "can be instanciated" do
  	Image.new(valid_attributes).should be_an_instance_of(Image)
  end

  it "can be saved" do
  	Image.create(valid_attributes).should be_persisted
  end

end
