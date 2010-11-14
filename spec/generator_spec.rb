require_relative "../generator"

describe "generator" do
  it "valid_lhs?() determines whether a sting is a valid VIM iabbrev LHS" do
    valid_lhs?("abc").should be_true
    valid_lhs?("a bc").should be_false
    valid_lhs?("a\tbc").should be_false
    valid_lhs?(" abc").should be_false
    valid_lhs?("\tabc").should be_false
    valid_lhs?("abc ").should be_false
    valid_lhs?("\tabc").should be_false
    valid_lhs?("abc;").should be_true
    valid_lhs?("abc;;").should be_true
    valid_lhs?("abc!$%&'-=()[]{}").should be_true
    valid_lhs?("abc;a").should be_false
    valid_lhs?("abc;;a").should be_false
    valid_lhs?("abc;a;").should be_false
    valid_lhs?("abc;a;;").should be_false
    valid_lhs?("abc;a;a").should be_false
    valid_lhs?(";abc").should be_false
  end
end
