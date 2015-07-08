module FipeApi
  class Utils
    def self.month_name_to_int(month_name)
      month_names = ["janeiro", "fevereiro", "março", "abril", "maio", "junho",
       "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]
      month_names.index(month_name)
    end
  end
end