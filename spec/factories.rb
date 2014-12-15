FactoryGirl.define do
	factory :doctor do
    id 0
    email "foo@foo.com" 
    password "secret"
    password_confirmation "secret"
    name "robert"
    state "RN"
    license "9090"
  end

  factory :case_log do
    id 0
    title "acne"
    patient_name "rudolph"
    images []
  end

  factory :image do
    id 0
    url "http://image.png"
    title "image1"
  end
end
