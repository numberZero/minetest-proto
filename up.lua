min_version = 37
max_version = 39

add_message{ id = 0x02, name = "Init", description = "Sent first after connected.", content = {
	{ name = "max_serialization_version", type = u8, description = "Serialisation version (serialisation format version highest read)" },
	{ name = "compression_support", type = u16, value = 0, description = "Supported network compression modes" },
	{ name = "min_network_version", type = u16, description = "Minimum supported network protocol version" },
	{ name = "max_network_version", type = u16, description = "Maximum supported network protocol version" },
	{ name = "player_name", type = utf8string, description = "Player name" },
}}

add_message{ id = 0x11, name = "Init2", description = "Sent as an ack for toclient init. After this, the server can send data.", content = {
	{ name = "lang", type = rawstring, default = "", description = "Client language code" },
}}

add_message{ id = 0x17, name = "ModChannelJoin", content = {
	{ name = "channel_name", type = utf8string, description = "Channel name" },
}}

add_message{ id = 0x18, name = "ModChannelLeave", content = {
	{ name = "channel_name", type = utf8string, description = "Channel name" },
}}

add_message{ id = 0x19, name = "ModChannelMsg", content = {
	{ name = "channel_name", type = utf8string, description = "Channel name" },
	{ name = "message", type = utf8string, description = "Message text" },
}}

local player_pos = record{ name = "PlayerPos", content = {
	{ name = "position", type = scaled{ type = v3s32, scale = 100 } },
	{ name = "speed", type = scaled{ type = v3s32, scale = 100 } },
	{ name = "pitch", type = scaled{ type = s32, scale = 100 } },
	{ name = "yaw", type = scaled{ type = s32, scale = 100 } },
	{ name = "keypressed", type = u32 }, -- битовое поле
	{ name = "fov", type = scaled{ type = u8, scale = 80 } },
	{ name = "wanted_range", type = u8, description = "Wanted range (in map blocks)" },
}}

add_message{ id = 0x23, name = "PlayerPos", content = {
	{ name = "pos", type = player_pos },
}}

add_message{ id = 0x24, name = "GotBlocks", content = {
	{ name = "pos", type = array{ size = u8, entry = v3s16 } },
}}

add_message{ id = 0x25, name = "DeletedBlocks", content = {
	{ name = "pos", type = array{ size = u8, entry = v3s16 } },
}}

add_message{ id = 0x31, name = "InventoryAction", content = raw }

add_message{ id = 0x32, name = "ChatMessage", content = {
	{ name = "message", type = utf16string },
}}

add_message{ id = 0x35, name = "Damage", content = {
	{ name = "amount", type = u16 }, -- u8 до 2019-02-10 (ffb17f1)
}}

add_message{ id = 0x37, name = "PlayerItem", description = "Sent to change selected item.", content = {
	{ name = "item", type = u16 },
}}

add_message{ id = 0x38, name = "Respawn" }

local action = enum{ name = "Action", type = u8, labels = {
	[0] = { name = "Start", description = "start digging (from undersurface) or use" },
	[1] = { name = "Stop", description = "stop digging (all parameters ignored)" },
	[2] = { name = "Completed", description = "digging completed" },
	[3] = { name = "Place", description = "place block or item (to abovesurface)" },
	[4] = { name = "Use", description = "use item" },
}}

local pointedthing = record{ name = "PointedThing", content = {
	{ name = "version", type = u8, value = 0 },
	variant{ selector = u8, options = {
		[0] = { name = "nothing" },
		[1] = { name = "node", content = {
			{ name = "under", type = v3s16 },
			{ name = "above", type = v3s16 },
		}},
		[2] = { name = "object", content = {
			{ name = "object_id", type = s16 },
		}},
	}}
}}

add_message{ id = 0x39, name = "Interact", content = {
	{ name = "action", type = action },
	{ name = "item", type = u16 },
	{ name = "pointed", type = blob, description = "Serialized PointedThing" },
	{ name = "pos", type = player_pos },
}}

add_message{ id = 0x3a, name = "RemovedSounds", content = {
	{ name = "sound_id", type = array{ size = u16, entry = s32 } },
}}

local meta_field = record{ name = "MetaField", content = {
	{ name = "name", type = utf8string },
	{ name = "value", type = blob },
}}

add_message{ id = 0x3b, name = "NodeMetaFields", content = {
	{ name = "p", type = v3s16 },
	{ name = "form_name", type = utf8string },
	{ name = "fields", type = array{ size = u16, entry = meta_field } },
}}

add_message{ id = 0x3c, name = "InventoryFields", content = {
	{ name = "form_name", type = utf8string },
	{ name = "fields", type = array{ size = u16, entry = meta_field } },
}}

add_message{ id = 0x40, name = "RequestMedia", content = {
	{ name = "files", type = array{ size = u16, entry = utf8string } },
}}

add_message{ id = 0x43, name = "ClientReady", content = {
	{ name = "major", type = u8 },
	{ name = "minor", type = u8 },
	{ name = "patch", type = u8 },
	{ name = "reserved", type = u8 },
	{ name = "full_version", type = utf8string },
	{ name = "formspec_version", type = u16, default = 1 },
}}

add_message{ id = 0x50, name = "FirstSrp", description = "Belonging to AuthMechanismFirstSrp", content = {
	{ name = "srp_salt", type = rawstring },
	{ name = "srp_verification_key", type = rawstring },
	{ name = "is_empty", type = b8 },
}}

add_message{ id = 0x51, name = "SrpBytesA", description = "Belonging to AuthMechanismSrp, depending on current login based on.", content = {
	{ name = "bytes_a", type = rawstring },
	{ name = "login_version", type = u8, description = "On which version of the password's hash this login is based on (0 legacy hash, or 1 directly the password)" },
}}

add_message{ id = 0x52, name = "SrpBytesM", description = "Belonging to AuthMechanismSrp", content = {
	{ name = "bytes_m", type = rawstring },
}}
