class Admin::ApiKeysController < Admin::RestfullController
  def attrs_for_index
    [:token]
  end

  def attrs_for_form
    [:token]
  end
end
