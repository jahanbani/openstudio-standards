require_relative '../../../helpers/minitest_helper'
require_relative '../../../helpers/necb_helper'
include(NecbHelper)

class NECB_BTAP_Data_Reporting < Minitest::Test

  def setup()
    define_folders(__dir__)
    define_std_ranges
  end

  # Test to validate btap_data.json generation
  def test_btap_data_reporting

    # Set up remaining parameters for test.
    output_folder = method_output_folder(__method__)
    expected_results_folder = "#{File.dirname(__FILE__)}/../expected_results/"
    template = 'NECB2011'
    standard = get_standard(template)
    save_intermediate_models = true

    # Generate the osm files for all relevant cases to generate the test data for system 6
    building_type = 'FullServiceRestaurant'
    primary_heating_fuel = 'NaturalGas'
    shw_fuel = 'FuelOilNo2'
    epw_file = 'CAN_ON_Toronto.Intl.AP.716240_CWEC2020.epw'

    # Generate osm file.
    model = standard.build(building_type: building_type,
                           epw_file: epw_file,
                           template: template,
                           primary_heating_fuel: primary_heating_fuel,
                           shw_fuel: shw_fuel,
                           sizing_run_dir: output_folder)

    model_name = "#{building_type}-#{template}-#{primary_heating_fuel}-#{shw_fuel}-#{File.basename(epw_file, '.epw')}"
    test_osm_file = "#{expected_results_folder}#{model_name}_test_result.osm"

    if !model.instance_of?(OpenStudio::Model::Model)
      puts "Creation of Model for #{model_name} failed. Please check output for errors."
      assert(false, "Model creation failed")
    else
      # Save the model to the expected results folder
      BTAP::FileIO.save_osm(model, test_osm_file)
      puts "saved test result osm file to #{test_osm_file}"
    end
  end
end
