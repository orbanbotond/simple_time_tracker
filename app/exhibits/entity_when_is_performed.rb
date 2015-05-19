class DurationHumanized < DisplayCase::Exhibit
  def applicable_to?(object, _context)
    field = self.field
    object.respond_to? :'in_preferred_hour?'
  end

  def status
    __getobj__.in_preferred_hour? ? 'Performed in Preferred Hours' : ''
  end
end
