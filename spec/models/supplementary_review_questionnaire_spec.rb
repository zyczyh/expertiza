def signup_topic
  user = User.find_by(name: "student2064")
  stub_current_user(user, user.role.name, user.role)
  visit '/student_task/list'
  visit '/sign_up_sheet/sign_up?id=1&topic_id=1' # signup topic
  visit '/student_task/list'
  click_link "TestAssignment"
  click_link "Your work"
end

describe "supplementary rubric testing" do
  before(:each) do
    create(:assignment, name: "TestAssignment", directory_path: "TestAssignment", 
         supplementary_review_questionnaire: true)
    create_list(:participant, 3)
    create(:assignment_team)
    create(:team_user, user: User.where(role_id: 2).first, team: AssignmentTeam.first)
    create(:topic, topic_name: "TestTopic")
    create(:deadline_type, name: "submission")
    create(:deadline_type, name: "review")
    create(:deadline_type, name: "metareview")
    create(:deadline_type, name: "drop_topic")
    create(:deadline_type, name: "signup")
    create(:deadline_type, name: "team_formation")
    create(:deadline_right)
    create(:deadline_right, name: 'Late')
    create(:deadline_right, name: 'OK')
    create(:assignment_questionnaire)
    create(:questionnaire)
    create(:question)
    create(:assignment_due_date, deadline_type: DeadlineType.where(name: "submission").first, due_at: DateTime.now.in_time_zone + 1.day)
  end

  it "has button" do
   signup_topic
   expect(page).to have_button("Create Supplementary Rubric")
  end

  it "redirect creating supplementary questionnaire" do
    signup_topic
    click_button "Create Supplementary Rubric"
  end
end