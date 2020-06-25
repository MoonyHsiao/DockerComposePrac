.PHONY: lo-% dev-% stg-% cli-% swagger build_mock check

# 建立 Binary 時的資訊
NOW = ${shell date -u +"%Y-%m-%d %H:%M:%S %Z"}
COMMIT = ${shell git rev-parse HEAD}

# 目錄中的 Config 與 .go 檔案
DATA = ${shell find . -path '*' -type f -name '*.go'}
LOCAL = config/config.yaml
DEV = config/dev.yaml
STG = config/stg.yaml
CLI = config/cli.yaml

test:
	# go test -cover $$(go list ./... | grep -E -v "vendor|integration")
	@echo "run in makefile test at $(NOW)" 

clean:
	# go clean
	# rm -rf vendor/
	# rm -rf release/
	# rm swagger.json





