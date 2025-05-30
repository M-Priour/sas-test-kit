module SasTestKit
  class VisualGroup < Inferno::TestGroup
    title 'Attestation (Prérequis, fonctionnalités, ...) '
    description 'Verification des prérequis et des  fonctionnalités du logiciel'
    id :visual_group

    test do
      title 'Gestion du RPPS pour les professionels de santé'
      description %(
          Gestion du RPPS pour les professionels de santé
      )
      id 'Test01'
      input :gestion_rpps,
            title: 'Est-ce que logiciel utilise le RPPS pour identifier les professionnels de santé ?',
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                {
                  label: 'Yes',
                  value: 'true'
                },
                {
                  label: 'No',
                  value: 'false'
                }
              ]
            }
      input :gestion_rpps_notes,
            title: 'Commentaire (en option)',
            type: 'textarea',
            optional: true

      run do
        pass gestion_rpps_notes 
      end
    end

    test do
      title 'Gestion du Finess pour les structures'
      description %(
          Gestion du Finess pour les stuctures
      )
      id 'Test02'
      input :gestion_finess,
            title: 'Est-ce que logiciel utilise le finess  pour identifier les structures ?',
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                {
                  label: 'Yes',
                  value: 'true'
                },
                {
                  label: 'No',
                  value: 'false'
                }
              ]
            }
      input :gestion_finess_notes,
            title: 'Commentaire (en option)',
            type: 'textarea',
            optional: true

      run do
        pass gestion_finess_notes 
      end
    end

  end
end
