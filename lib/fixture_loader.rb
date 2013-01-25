module FixtureLoader

  def self.load(filename)
    File.read File.join(Rails.root, 'app', 'fixtures', filename)
  end

end
