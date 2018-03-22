RSpec.shared_examples 'guest' do
  before do
    subject
  end

  it 'shoul redirect to login page' do
    expect(subject).to redirect_to(new_user_session_path)
  end
end
