# mc_te

### Prerequisites 
1. Ruby 
2. Google Chrome
3. Google Chrome driver: http://chromedriver.chromium.org/downloads

To run tests locally from command line and generate the leadership CSV:

### install bundler
```
gem install bundler
```
### clone repo: 
```
git clone https://github.com/plattnervision/mc_te.git
```
### navigate to repo:
```
cd mc_te
```
### install dependencies: 
```
bundle install 
```
### run test suite: 
```
cucumber 
```

Once the test suite completes there will be a csv created titled "leadership.csv"
