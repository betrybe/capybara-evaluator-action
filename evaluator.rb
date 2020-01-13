require 'json'
require 'net/http'

GITHUB_USERNAME = (ENV['GITHUB_ACTOR'] || 'no_user').freeze
GITHUB_REPOSITORY = (ENV['GITHUB_REPOSITORY'] || 'no_repository').freeze

requirements_mapping_file_path = File.join(File.absolute_path('.'), '/requirements_mapping.json')
requirements_mapping = JSON.parse(File.read(requirements_mapping_file_path))

evaluations_file_path = File.join(File.absolute_path('.'), '/evaluation.json')
evaluations_file = JSON.parse(File.read(evaluations_file_path))['examples']
evaluations = evaluations_file.map do |evaluation|
  {
    requirement_id: requirements_mapping[evaluation['description']],
    grade: (evaluation['status'] == 'passed' && 3) || (evaluation['status'] == 'failed' && 1) || 0
  }
end

result = {
  github_username: GITHUB_USERNAME,
  github_repository_name: GITHUB_REPOSITORY,
  evaluations: evaluations
}

evaluation_uri = URI('https://trybe-evaluation.herokuapp.com/evaluation')
Net::HTTP.post(evaluation_uri, result.to_json, 'Content-Type' => 'application/json')
