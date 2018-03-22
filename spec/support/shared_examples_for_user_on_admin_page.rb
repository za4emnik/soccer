RSpec.shared_examples 'user on admin page' do
  login_user
  it_behaves_like 'redirect to', 'root_path'
end
