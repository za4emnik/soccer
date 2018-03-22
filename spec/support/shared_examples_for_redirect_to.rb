RSpec.shared_examples 'redirect to' do |path|

  before do
    subject
  end

  it "should redirect to #{path}" do
    expect(subject).to redirect_to(send(path))
  end
end
