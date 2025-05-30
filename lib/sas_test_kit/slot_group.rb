module MyTestKit
  class SlotGroup < Inferno::TestGroup
    title 'Slot Tests'
    description 'Verification sur Slot'
    id :slot_group

    test do
      title 'Test lecture slot'
      description %(
        Verification  que le serveur renvoie la ressource Slot passée en paramètre
      )

      input :slot_id,
            title: 'Slot ID'

      output :body  
      output :test    

      # Named requests can be used by other tests
      makes_request :slot 

      run do
        fhir_read(:slot, slot_id)
 
        assert_response_status(200)  
        assert_valid_json(request.response_body)
        assert_resource_type(:slot)
        #assert resource.id == slot_id,
        #       "Requested resource with id #{slot_id}, received resource with id #{resource.id}"
        assert_valid_resource(profile_url: 'https://interop.esante.gouv.fr/ig/fhir/sas/StructureDefinition/sas-cpts-slot-aggregator')                
      end
    end

    test do
      title 'Test recherche par slot -renvoi Bundle'
      description %(
        Verifier la recherche par ressource Slot et le renvoie d'un Bundle
      )

      input :practitioner_id,
            title: 'RPPS',
            default: '810100901734'


      output :body
      output :test       
    

      run do
        fhir_search('Slot', params: { _include: 'Slot:schedule', 
        '_include:iterate': 'Schedule:actor',
        'schedule.actor:Practitioner.identifier': 'urn:oid:1.2.250.1.71.4.2.1|'+ practitioner_id,
        start: 'ge2025-03-31T00:00:00.000',
        status: 'free'})
        #multiparamètre de recherche plus caractères spéciaux à gérer


        assert_response_status(200)
        assert_resource_type('Bundle')
        #verification content type
        warning do
          assert_response_content_type('application/fhir+json')
        end
        
        #A corriger avec fhir path evaluation assert (resource.entry.where(resource.resourceType='Slot').count()) > resource.total
        #output body: resource.to_json
        results = evaluate_fhirpath(resource: resource, path: 'total')
        add_message('info', "Total (bundle) : " + results[0]["element"].to_s)        
        #results1 = evaluate_fhirpath(resource: resource, path: 'entry.resource.ofType(Slot).count()')
        results1 = evaluate_fhirpath(resource: resource, path: 'entry.resource.count()')
        add_message('info', "Total (Calculé) : " + results1[0]["element"].to_s) 
        assert_valid_resource(profile_url: 'https://interop.esante.gouv.fr/ig/fhir/sas/StructureDefinition/sas-cpts-bundle-aggregator')  
        #assert_valid_resource(validator: :validator_sas)
        assert_valid_bundle_entries(resource_types: 'Practitioner')
        #output test: resource.entry[0].fullUrl
      
      end
    end

  end
end
