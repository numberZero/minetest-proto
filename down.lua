add_message{ id = 0x02, name = "Hello", description = "Sent as response to Init", content = {
	{ name = "serialization_version", type = u8, description = "Deployed serialisation version" },
	{ name = "compression", type = u16, value = 0, description = "Deployed network compression mode" },
	{ name = "protocol_version", type = u16, description = "Deployed protocol version" },
	{ name = "auth_methods", type = u32, description = "Supported auth methods" },
	{ name = "username", type = rawstring, description = "Username that should be used for legacy hash (for proper casing)" },
}}

add_message{ id = 0x03, name = "AuthAccept", description = "Message from server to accept auth.", content = {
	{ name = "player_position", type = v3f, description = "Player's position + v3f(0, BS/2, 0) floatToInt’d" },
	{ name = "map_seed", type = u64 },
	{ name = "send_interval", type = f32, description = "Recommended send interval" },
	{ name = "sudo_auth_methods", type = u32, description = "Supported auth methods for sudo mode (where the user can change their password)" },
}}

add_message{ id = 0x04, name = "AcceptSudoMode", description = "Sent to client to show it is in sudo mode now." }

add_message{ id = 0x05, name = "DenySudoMode", description = "Signals client that sudo mode auth failed." }

add_message{ id = 0x0A, name = "AccessDenied", content = {
	{ name = "reason", type = u8 },
	{ name = "custom_reason", type = utf8string, default = "" },
	{ name = "reconnect", type = b8, default = false },
}}

add_message{ id = 0x20, name = "BlockData", content = {
	{ name = "position", type = v3s16 },
	{ name = "data", type = raw } -- до конца пакета
}}

local map_node = record{ name = "MapNode", description = "MapNode serialization version 24 and above", content = {
	{ name = "content", type = u16 },
	{ name = "param1", type = u8 },
	{ name = "param2", type = u8 },
}}

add_message{ id = 0x21, name = "AddNode", content = {
	{ name = "position", type = v3s16 },
	{ name = "mapnode", type = map_node },
	{ name = "keep_metadata", type = b8 }, -- Added in protocol version 22
}}

add_message{ id = 0x21, name = "RemoveNode", content = {
	{ name = "position", type = v3s16 },
}}

add_message{ id = 0x27, name = "Inventory", content = {
	{ name = "data", type = raw } -- до конца пакета
}}

add_message{ id = 0x29, name = "TimeOfDay", content = {
	{ name = "time", type = u16 },
	{ name = "time_speed", type = f32 }, -- добавлен позже
}}

add_message{ id = 0x2A, name = "CsmRestrictionFlags", content = {
	{ name = "flags", type = u64 },
	{ name = "range", type = u32 },
}}

add_message{ id = 0x2B, name = "PlayerSpeed", content = {
	{ name = "added_vel", type = v3f },
}}

add_message{ id = 0x2C, name = "MediaPush", content = {
	{ name = "raw_hash", type = rawstring },
	{ name = "filename", type = utf8string },
	{ name = "cache", type = b8 },
	{ name = "filedata", type = blob },
}}

add_message{ id = 0x2F, name = "ChatMessage", content = {
	{ name = "version", type = u8 },
	{ name = "type", type = u8 },
	{ name = "sender", type = utf16string },
	{ name = "message", type = utf16string },
	{ name = "time", type = u64 },
}}

add_message{ id = 0x31, name = "ActiveObjectRemoveAdd", content = {
	{ name = "removed_objects", type = array{ size = u16, entry = u16 } },
	{ name = "added_objects", type = array{
		size = u16,
		entry = record{ content = {
			{ name = "id", type = u16 },
			{ name = "type", type = u8 },
			{ name = "initialization_data", type = blob },
		}}
	}},
}}

add_message{ id = 0x32, name = "ActiveObjectMessages", content = {
	{ name = "messages", type = array{
		entry = record{ content = {
			{ name = "id", type = u16 },
			{ name = "message", type = rawstring },
		}}
	}} -- до конца пакета
}}

add_message{ id = 0x33, name = "Hp", content = {
	{ name = "hp", type = u16 },
}}

add_message{ id = 0x34, name = "MovePlayer", content = {
	{ name = "position", type = v3f },
	{ name = "pitch", type = f32 },
	{ name = "yaw", type = f32 },
}}

add_message{ id = 0x35, name = "AccessDeniedLegacy", content = {
	{ name = "reason", type = utf16string },
}}

add_message{ id = 0x36, name = "Fov", description = "Sends an FOV override/multiplier to client.", content = {
	{ name = "fov", type = f32 },
	{ name = "is_multiplier", type = b8 },
	{ name = "transition_time", type = f32 },
}}

add_message{ id = 0x37, name = "DeathScreen", content = {
	{ name = "set_camera_target", type = b8 },
	{ name = "camera_target", type = v3f, description = "Camera point target (to point the death cause or whatever)" },
}}

add_message{ id = 0x38, name = "Media", content = {
	{ name = "bunch_count", type = u16, description = "total number of texture bunches" },
	{ name = "bunch_id", type = u16, description = "index of this bunch" },
	{ name = "files", type = array{
		size = u32,
		entry = record{ content = {
			{ name = "name", type = utf8string },
			{ name = "data", type = blob },
		}},
	}},
}}

add_message{ id = 0x3a, name = "NodeDef", content = {
	{ name = "data", type = blob, description = "ZLib-compressed serialized data" },
}}

add_message{ id = 0x3c, name = "AnnounceMedia", content = {
	{ name = "files", type = array{
		size = u16,
		entry = record{ content = {
			{ name = "name", type = utf8string },
			{ name = "digest", type = utf8string, description = "Base64-encoded SHA-1 digest" },
		}},
	}},
	{ name = "content_servers", type = utf8string, default = "" },
}}

add_message{ id = 0x3d, name = "ItemDef", content = {
	{ name = "data", type = blob, description = "ZLib-compressed serialized data" },
}}

add_message{ id = 0x3f, name = "PlaySound", content = {
	{ name = "sound_id", type = s32 },
	{ name = "sound_name", type = rawstring },
	{ name = "gain", type = f32 },
	{ name = "type", type = enum{ name = "SoundType", type = u8, labels = {
		[0] = "local",
		[1] = "positional",
		[2] = "object",
	}}},
	{ name = "position", type = v3f },
	{ name = "object_id", type = u16 },
	{ name = "loop", type = b8 },
	{ name = "fade", type = f32, default = 0.0 },
	{ name = "pitch", type = f32, default = 1.0 },
	{ name = "ephemeral", type = b8, default = false },
}}

add_message{ id = 0x40, name = "StopSound", content = {
	{ name = "sound_id", type = s32 },
}}

add_message{ id = 0x41, name = "Privileges", content = {
	{ name = "privileges", type = array{ size = u16, entry = rawstring } },
}}

add_message{ id = 0x42, name = "InventoryFormspec", content = {
	{ name = "formspec", type = blob, description = "Raw uncompressed formspec" },
}}

add_message{ id = 0x43, name = "DetachedInventory", content = {
	{ name = "name", type = utf8string },
	variant{ selector = u8, options = {
		[0] = { name = "remove" },
		[1] = { name = "update", content = {
			{ type = u16 },
			{ name = "data", type = raw, description = "Uncompressed serialized inventory" },
		}},
	}},
}}

add_message{ id = 0x44, name = "ShowFormspec", content = {
	{ name = "formspec", type = blob },
	{ name = "formname", type = rawstring },
}}

add_message{ id = 0x45, name = "Movement", content = {
	{ name = "movement_acceleration_default", type = f32 },
	{ name = "movement_acceleration_air", type = f32 },
	{ name = "movement_acceleration_fast", type = f32 },
	{ name = "movement_speed_walk", type = f32 },
	{ name = "movement_speed_crouch", type = f32 },
	{ name = "movement_speed_fast", type = f32 },
	{ name = "movement_speed_climb", type = f32 },
	{ name = "movement_speed_jump", type = f32 },
	{ name = "movement_liquid_fluidity", type = f32 },
	{ name = "movement_liquid_fluidity_smooth", type = f32 },
	{ name = "movement_liquid_sink", type = f32 },
	{ name = "movement_gravity", type = f32 },
}}

local tile_animation = record{ name = "TileAnimation", content = {
	variant{ selector = u8, options = {
		[0] = { name = "none" },
		[1] = { name = "vertical_frames", content = {
			{ name = "aspect_w", type = u16 },
			{ name = "aspect_h", type = u16 },
			{ name = "length", type = f32 },
		}},
		[2] = { name = "sheet_2d", content = {
			{ name = "frames_w", type = u8 },
			{ name = "frames_h", type = u8 },
			{ name = "frame_length", type = f32 },
		}},
	}},
}}

local particle_node = record{ name = "ParticleNode", content = { -- зависит от версии
	{ name = "content", type = u16 },
	{ name = "param2", type = u8 },
	{ name = "tile", type = u8 },
}}

add_message{ id = 0x46, name = "SpawnParticle", content = {
	{ name = "pos", type = v3f },
	{ name = "velocity", type = v3f },
	{ name = "acceleration", type = v3f },
	{ name = "expiration_time", type = f32 },
	{ name = "size", type = f32 },
	{ name = "collision_detection", type = b8 },
	{ name = "texture", type = blob },
	{ name = "vertical", type = b8 },
	{ name = "collision_removal", type = b8 },
	{ name = "animation", type = tile_animation }, -- всегда версии 6
	{ name = "glow", type = u8 },
	{ name = "object_collision", type = b8 },
	{ name = "node", type = particle_node, required = false },
}}

add_message{ id = 0x47, name = "AddParticleSpawner", content = {
	{ name = "amount", type = u16 },
	{ name = "spawntime", type = f32 },
	{ name = "minpos", type = v3f },
	{ name = "maxpos", type = v3f },
	{ name = "minvel", type = v3f },
	{ name = "maxvel", type = v3f },
	{ name = "minacc", type = v3f },
	{ name = "maxacc", type = v3f },
	{ name = "minexptime", type = f32 },
	{ name = "maxexptime", type = f32 },
	{ name = "minsize", type = f32 },
	{ name = "maxsize", type = f32 },
	{ name = "collision_detection", type = b8 },
	{ name = "texture", type = blob },
	{ name = "id", type = u32 },
	{ name = "vertical", type = b8 },
	{ name = "collision_removal", type = b8 },
	{ name = "attached_id", type = u16 },
	{ name = "animation", type = tile_animation },
	{ name = "glow", type = u8 },
	{ name = "object_collision", type = b8 },
	{ name = "node", type = particle_node, required = false },
}}

add_message{ id = 0x49, name = "HudAdd", content = {
	{ name = "id", type = u32 },
	{ name = "type", type = u8 },
	{ name = "pos", type = v2f },
	{ name = "name", type = rawstring },
	{ name = "scale", type = v2f },
	{ name = "text", type = utf8string },
	{ name = "number", type = u32 },
	{ name = "item", type = u32 },
	{ name = "dir", type = u32 },
	{ name = "align", type = v2f },
	{ name = "offset", type = v2f },

	{ name = "world_pos", type = v3f },
	{ name = "size", type = v2s32 },
	{ name = "z_index", type = s16 },
	{ name = "text2", type = utf8string },
}}

add_message{ id = 0x4a, name = "HudRemove", content = {
	{ name = "id", type = u32 },
}}

add_message{ id = 0x4b, name = "HudChange", content = {
	{ name = "id", type = u32 },
	variant{ selector = u8, options = { [0] =
		{ name = "pos", content = v2f },
		{ name = "name", content = utf8string },
		{ name = "scale", content = v2f },
		{ name = "text", content = utf8string },
		{ name = "number", content = u32 },
		{ name = "item", content = u32 },
		{ name = "dir", content = u32 },
		{ name = "align", content = v2f },
		{ name = "offset", content = v2f },
		{ name = "world_pos", content = v3f },
		{ name = "size", content = v2s32 },
		{ name = "z_index", content = u32 },
		{ name = "text2", content = utf8string },
	}}
}}

add_message{ id = 0x4c, name = "HudSetFlags", content = {
	{ name = "flags", type = u32 },
	{ name = "mask", type = u32 },
}}

add_message{ id = 0x4d, name = "HudSetParam", content = {
	{ name = "param", type = u16 },
	{ name = "value", type = rawstring },
}}

add_message{ id = 0x4e, name = "Breath", content = {
	{ name = "breath", type = u16 },
}}

add_message{ id = 0x4f, name = "SetSky", version = "<39", content = {
	{ name = "base_color", type = color },
	{ name = "type", type = rawstring },
	{ name = "textures", type = array{ size = u16, entry = utf8string } },
	{ name = "clouds", type = b8, default = true },
}}

add_message{ id = 0x4f, name = "SetSky", version = "39", content = {
	{ name = "bgcolor", type = color },
	{ name = "type", type = utf8string },
	{ name = "clouds", type = b8 },
	{ name = "fog_sun_tint", type = color },
	{ name = "fog_moon_tint", type = color },
	{ name = "fog_tint_type", type = utf8string },
	variant{
		selector = "type",
		unknown = "ignore",
		options = {
			regular = {
				{ name = "day_sky", type = color },
				{ name = "day_horizon", type = color },
				{ name = "dawn_sky", type = color },
				{ name = "dawn_horizon", type = color },
				{ name = "night_sky", type = color },
				{ name = "night_horizon", type = color },
				{ name = "indoors", type = color },
			},
			skybox = {
				{ name = "textures", type = array{ size = u16, entry = utf8string } },
			},
		},
	},
}}

add_message{ id = 0x50, name = "OverrideDayNightRatio", content = {
	{ name = "do_override", type = b8 },
	{ name = "day_night_ratio", type = u16 },
}}

add_message{ id = 0x51, name = "LocalPlayerAnimations", content = {
	{ name = "stand", type = v2s32 },
	{ name = "walk", type = v2s32 },
	{ name = "dig", type = v2s32 },
	{ name = "walk_dig", type = v2s32 },
	{ name = "frame_speed", type = f32 },
}}

add_message{ id = 0x52, name = "EyeOffset", content = {
	{ name = "first", type = v3f },
	{ name = "third", type = v3f },
}}

add_message{ id = 0x53, name = "DeleteParticleSpawner", content = {
	{ name = "id", type = u32 },
}}

add_message{ id = 0x54, name = "CloudParams", content = {
	{ name = "density", type = f32 },
	{ name = "color_diffuse", type = color },
	{ name = "color_ambient", type = color },
	{ name = "height", type = f32 },
	{ name = "thickness", type = f32 },
	{ name = "speed", type = v2f },
}}

add_message{ id = 0x55, name = "FadeSound", content = {
	{ name = "sound_id", type = s32 },
	{ name = "step", type = f32 },
	{ name = "gain", type = f32 },
}}

add_message{ id = 0x56, name = "UpdatePlayerList", content = {
	{ name = "action", type = enum{ type = u8, labels = {
		[0] = "init",
		[1] = "add",
		[2] = "remove",
	}}},
	{ name = "player_names", type = array{ size = u16, entry = utf8string } },
}}

add_message{ id = 0x57, name = "ModChannelMsg", content = {
	{ name = "channel_name", type = utf8string },
	{ name = "sender", type = utf8string },
	{ name = "message", type = utf8string },
}}

local mod_channel_state = enum{ name = "ModChannelState", type = u8, labels = { [0] =
	"init",
	"read_write",
	"read_only",
}}

add_message{ id = 0x58, name = "ModChannelSignal", content = {
	{ name = "signal", type = enum{ type = u8, labels = { [0] =
		"join_ok",
		"join_failure",
		"leave_ok",
		"leave_failure",
		"channel_not_registered",
		"set_state",
	}}},
	{ name = "channel_name", type = utf8string },
	variant{
		selector = "signal",
		unknown = "ignore",
		options = {
			set_state = {
				{ name = "state", type = mod_channel_state },
			},
		},
	},
}}

add_message{ id = 0x59, name = "NodeMetaChanged", content = {
	{ name = "changes", type = blob, description = "ZLib-compressed change list" },
}}

add_message{ id = 0x5a, name = "SetSun", content = {
	{ name = "visible", type = b8 },
	{ name = "texture", type = utf8string },
	{ name = "tonemap", type = utf8string },
	{ name = "sunrise", type = utf8string },
	{ name = "sunrise_visible", type = b8 },
	{ name = "scale", type = f32 },
}}

add_message{ id = 0x5b, name = "SetMoon", content = {
	{ name = "visible", type = b8 },
	{ name = "texture", type = utf8string },
	{ name = "tonemap", type = utf8string },
	{ name = "scale", type = f32 },
}}

add_message{ id = 0x5c, name = "SetStars", content = {
	{ name = "visible", type = b8 },
	{ name = "count", type = u32 },
	{ name = "color", type = color },
	{ name = "scale", type = f32 },
}}

add_message{ id = 0x60, name = "SrpBytesSB", description = "Belonging to AuthMechanismSrp", content = {
	{ name = "bytes_s", type = rawstring },
	{ name = "bytes_B", type = rawstring },
}}

add_message{ id = 0x61, name = "FormspecPrepend", content = {
	{ name = "formspec", type = rawstring },
}}
