# The postgres version is listed on derpibooru
# On the same page where the dump is located
FROM postgres:15

COPY ./dump/ /dump/
