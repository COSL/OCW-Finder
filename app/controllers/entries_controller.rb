class EntriesController < Muck::EntriesController
  before_filter :setup_grain_size
  
  def setup_grain_size
    @grain_size = 'course'
  end
  
end
