module MyTestKit
  class PerformanceGroup < Inferno::TestGroup
    title 'Test de performance'
    description 'Tets de performance'
    id :performance_group



    test do
      title 'Test de performance'
      description %(
        Verification des temps de réponse 
      )

      input :practitioner_id,
            title: 'RPPS',
            default: '810100901734'



    

      run do

        wait_time = 1
        start = Time.now
        used_time = 0

        fhir_search('Slot', params: { _include: 'Slot:schedule', 
        '_include:iterate': 'Schedule:actor',
        'schedule.actor:Practitioner.identifier': 'urn:oid:1.2.250.1.71.4.2.1|'+ practitioner_id,
        start: 'ge2025-03-31T00:00:00.000',
        status: 'free'})

        #multiparamètre de recherche plus caractères spéciaux à gérer


        assert_response_status(200)
        assert_resource_type('Bundle')
        used_time = Time.now - start        
        add_message('info', "Temps de réponse : " + used_time.to_s) 
        assert used_time < 1, 'Temps de réponse supérieur à 1 seconde' 
        
      end
    end

  end
end
