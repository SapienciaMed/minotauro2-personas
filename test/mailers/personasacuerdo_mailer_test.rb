require 'test_helper'

class PersonasacuerdoMailerTest < ActionMailer::TestCase
  test "user" do
    mail = PersonasacuerdoMailer.user
    assert_equal "User", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "personasacuerdo" do
    mail = PersonasacuerdoMailer.personasacuerdo
    assert_equal "Personasacuerdo", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
