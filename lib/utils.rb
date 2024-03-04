# frozen_string_literal: true

module Swagger
    class Utils
        def self.time_now
            t = Time.now
            year = t.year
            month = t.month.to_s.rjust(2, '0')
            day = t.day.to_s.rjust(2, '0')
            hr = t.hour.to_s.rjust(2, '0')
            min = t.min.to_s.rjust(2, '0')
            "#{year}-#{month}-#{day} #{hr}:#{min}"
        end
    end
end