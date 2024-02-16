KEYDB_IMAGE_VERSION=x86_64_v6.3.4
REJSON_VER=v2.4.2
REDISEARCH_VERSION=v2.6.12

# keydb_main:
# 	docker build --build-arg BRANCH=$(KEYDB_IMAGE_VERSION) -t keydb_main .
	

# jsonsearch: keydb_main
# 	docker build -t keydb_json_search --build-arg REDISEARCH_BRANCH=$(REDISEARCH_VERSION) --build-arg REJSON_BRANCH=$(REJSON_VER) -f Dockerfile.keydb_json_search .

# runjsonsearch: jsonsearch
# 	docker run --rm -it keydb_json_search

search: 
	docker build -t keydb_redisearch \
	--build-arg KEYDB_IMAGE_VERSION=$(KEYDB_IMAGE_VERSION) \
	--build-arg \
	BRANCH=$(REDISEARCH_VERSION) .

runsearch: search 
	docker run --name redisearch -it keydb_redisearch
