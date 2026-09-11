CREATE TABLE `assets` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`kind` INTEGER NOT NULL,
	`kind_id` INTEGER NOT NULL,
	`type` INTEGER NOT NULL,
	`name` TEXT NOT NULL,
	`description` TEXT NOT NULL,
	`format` INTEGER NOT NULL,
	`size` INTEGER NOT NULL,
	`blob_id` INTEGER NOT NULL
, debug TEXT);

CREATE TABLE `blobs` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`size` INTEGER NOT NULL,
	`crc32` TEXT NOT NULL,
	`md5` TEXT NOT NULL,
	`sha256` TEXT NOT NULL
);

CREATE TABLE `developers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT);

CREATE TABLE `entries` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`asset_id` INTEGER NOT NULL,
	`name` TEXT NOT NULL,
	`size` INTEGER NOT NULL,
	`blob_id` INTEGER NOT NULL
);

CREATE TABLE `game_developers` (
	`game_id` INTEGER NOT NULL,
	`developer_id` INTEGER NOT NULL,
	UNIQUE (`game_id`, `developer_id`)
);

CREATE TABLE `game_genres` (
	`game_id` INTEGER NOT NULL,
	`genre_id` INTEGER NOT NULL,
	UNIQUE (`game_id`, `genre_id`)
);

CREATE TABLE `games` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`platform_id` INTEGER NOT NULL,
	`description` TEXT NOT NULL
, series_id INTEGER NOT NULL DEFAULT 0);

CREATE TABLE `genres` (`id` INTEGER PRIMARY KEY AUTOINCREMENT);

CREATE TABLE `names` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`kind` INTEGER NOT NULL,
	`kind_id` INTEGER NOT NULL, -- owner entity id.
	`language` INTEGER NOT NULL,
	`name` TEXT NOT NULL
, source TEXT NOT NULL DEFAULT '');

CREATE TABLE `options` (
    `id` INTEGER  PRIMARY KEY AUTOINCREMENT,
    `name` TEXT  NOT NULL UNIQUE COLLATE NOCASE,
    `value` TEXT  NOT NULL
);

CREATE TABLE `platforms` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`description` TEXT NOT NULL
);

CREATE TABLE `publishers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT);

CREATE TABLE `release_publishers` (
	`release_id` INTEGER NOT NULL,
	`publisher_id` INTEGER NOT NULL,
	UNIQUE (`release_id`, `publisher_id`)
);

CREATE TABLE `releases` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`game_id` INTEGER NOT NULL,
	`description` TEXT NOT NULL,
	`release_date` INTEGER NOT NULL
);

CREATE TABLE rom_sets (id INTEGER PRIMARY KEY AUTOINCREMENT, emulator TEXT NOT NULL, version TEXT NOT NULL, short_name TEXT NOT NULL, asset_id INTEGER NOT NULL, UNIQUE(emulator,version,short_name));

CREATE TABLE series (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NOT NULL);

CREATE INDEX assets_kind_kind_id ON assets (kind, kind_id);

CREATE INDEX blobs_crc32_size ON blobs(crc32,size);

CREATE UNIQUE INDEX blobs_sha256 ON blobs(sha256) WHERE sha256<>'';

CREATE INDEX entries_asset_id ON entries (asset_id);

CREATE INDEX games_platform_id ON games (platform_id);

CREATE INDEX games_series_id ON games (series_id);

CREATE INDEX names_kind_kind_id ON names (kind, kind_id);

CREATE INDEX releases_game_id ON releases (game_id);

CREATE INDEX rom_sets_asset_id ON rom_sets(asset_id);
