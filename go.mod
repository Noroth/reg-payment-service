module github.com/eurofurence/reg-payment-service

go 1.18

require (
	github.com/StephanHCB/go-autumn-logging v0.3.0
	github.com/StephanHCB/go-autumn-logging-zerolog v0.3.1
	github.com/StephanHCB/go-autumn-restclient v0.5.0
	github.com/StephanHCB/go-autumn-restclient-circuitbreaker v0.4.1
	github.com/go-chi/chi/v5 v5.0.8
	github.com/go-http-utils/headers v0.0.0-20181008091004-fed159eddc2a
	github.com/golang-jwt/jwt/v4 v4.4.3
	github.com/google/uuid v1.3.0
	gorm.io/driver/mysql v1.4.6
	gorm.io/gorm v1.24.5
)

require github.com/rs/zerolog v1.29.0

require (
	github.com/go-sql-driver/mysql v1.7.0 // indirect
	github.com/jinzhu/inflection v1.0.0 // indirect
	github.com/jinzhu/now v1.1.5 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.16 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/sony/gobreaker v0.5.0 // indirect
	golang.org/x/sys v0.1.0 // indirect
)

require (
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/stretchr/testify v1.8.1
	gopkg.in/yaml.v3 v3.0.1
)
