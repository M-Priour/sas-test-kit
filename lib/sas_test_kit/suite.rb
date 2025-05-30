require_relative 'metadata'
require_relative 'performance_group'
require_relative 'visual_group'
require_relative 'slot_group'
require_relative 'tls_test_suite'

module SasTestKit
  class Suite < Inferno::TestSuite
    id :sas
    title 'Sas Test Kit Test Suite'
    description %(
          #  Qu’est-ce que la plateforme numérique du SAS ?
          La plateforme numérique du service d’accès aux soins (SAS) est un outil dédié aux professionnels de la chaîne de régulation médicale pour faciliter l’orientation vers la médecine de ville. Simple et modulable, elle facilite l’accès à l’offre de soins disponible et s’intègre dans l’écosystème du numérique en santé.

          #  Développement et recette connectée
          Cette suite de test est mise à diposition pour faliciter la recette connecté
        )

    input_order :url, :gestion_rpps, :gestion_rpps_notes,:gestion_finess,:gestion_finess_notes, :slot_id, :practitioner_id

     input_instructions %(
        Afin de lancer les tests vous devez compléter l'ensemble des éléments.
      )

    # These inputs will be available to all tests in this suite
    input :url,
          title: 'URl du serveur'

    #input :credentials,
    #      title: 'OAuth Credentials',
    #      type: :oauth_credentials,
    #      optional: true

    # All FHIR requests in this suite will use this FHIR client
    fhir_client do
      url :url
      ssl_client_cert OpenSSL::X509::Certificate.new(File.read("./config/cert/inferno.pem")) 
      ssl_client_key OpenSSL::PKey::RSA.new(File.read("./config/cert/inferno.key"))      
      #oauth_credentials :credentials
    end

    # All FHIR validation requests will use this FHIR validator
    fhir_resource_validator do
       #url 'https://interop.esante.gouv.fr/matchboxv3/fhir/'
       igs 'ans.fhir.fr.sas#1.1.0' # Use this method for published IGs/versions
       igs 'igs/sas_package.tgz'   # Use this otherwise

      exclude_message do |message|
        message.message.match?(/\A\S+: \S+: URL value '.*' does not resolve/)
      end
    end
    group from: :visual_group     
    group from: :tls

    # Tests and TestGroups can be defined inline
    group do
      id :capability_statement
      title 'Capability Statement'
      description 'Verification de la présence du  CapabilityStatement sur le serveur'

      test do
        id :capability_statement_read
        title 'Recupération du  CapabilityStatement'
        description 'Récupération  du CapabilityStatement du endpoint  /metadata '

        run do
          fhir_get_capability_statement

          assert_response_status(200)
          assert_resource_type(:capability_statement) 
        end
      end
    end

    # Tests and TestGroups can be written in separate files and then included
    # using their id

    group from: :slot_group    
    group from: :performance_group

  end
end 