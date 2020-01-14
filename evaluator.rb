require 'json'

GITHUB_USERNAME = (ENV['GITHUB_ACTOR'] || 'no_user').freeze
GITHUB_REPOSITORY = (ENV['GITHUB_REPOSITORY'] || 'no_repository').freeze

def path_for(file_name)
  File.join(File.absolute_path('.'), '/', file_name)
end

requirements_mapping = JSON.parse(File.read(path_for('requirements_mapping.json')))

evaluations = JSON.parse(File.read(path_for('evaluation.json')))['examples'].map do |evaluation|
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

File.write(path_for('result.json'), result.to_json)
