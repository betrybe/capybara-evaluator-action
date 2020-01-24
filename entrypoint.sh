#!/bin/sh -l

git clone https://github.com/$GITHUB_REPOSITORY.git -b test-action /capybara_evaluator_action/spec/project
git clone https://github.com/$GITHUB_REPOSITORY-tests.git -b feature/set-hardcoded-project-path /capybara_evaluator_action/spec/project/project-test
cp /capybara_evaluator_action/spec/project/project-test/requirements_mapping.json /capybara_evaluator_action
cd /capybara_evaluator_action

bundle exec rspec --format json --out evaluation.json

# cp evaluation.json /app/
cat evaluation.json

ruby evaluator.rb

if [ $? != 0 ]
then
  echo "Execution error"
  exit 1
fi

cat result.json

echo ::set-output name=evaluation::`cat evaluation.json | base64 -w 0`
echo ::set-output name=result::`cat result.json | base64 -w 0`
echo ::set-output name=pr-number::$(echo "$GITHUB_REF" | awk -F / '{print $3}')
