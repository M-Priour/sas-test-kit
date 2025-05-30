require_relative 'version'

module SasTestKit
  class Metadata < Inferno::TestKit
    id :sas
    title 'Sas Test Kit'
    description <<~DESCRIPTION
      This is a big markdown description of the test kit.
    DESCRIPTION
    suite_ids [:sas]
    # tags ['SMART App Launch', 'US Core']
    # last_updated '2024-03-07'
    version VERSION
    maturity 'Low'
    authors ["mpriour"]
    # repo 'TODO'
  end
end
