RSpec.shared_examples 'redirect to' do |path|
  before do
    subject
  end

  it "should redirect to #{path}" do
    url = path ? send(path) : params
    expect(subject).to redirect_to(url)
  end
end
