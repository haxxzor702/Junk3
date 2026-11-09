extends Node2D
## Emberwild prototype with warrior melee update.

const CLASSES = ["Knight", "Archer", "Sorcerer", "Cleric", "Rogue"]
const COLORS = [Color("e5a65d"), Color("88d36c"), Color("a68cff"), Color("f9df83"), Color("85dbe4")]
const SAVE_PATH = "user://characters.json"
# The five same-sized regions form a cross, not a full 3x3 square.
const ZONE_SIZE = 7280.0
const WORLD_SIZE = ZONE_SIZE * 3.0
const FOREST_START = ZONE_SIZE
const FOREST_END = ZONE_SIZE * 2.0
const DESIGN_VIEW = Vector2(960, 540)
var VIEW: Vector2 = DESIGN_VIEW
const TOWN = Vector2(10920, 10920)
const CASTLE_HALF = Vector2(600.0, 500.0)
const CASTLE_GATE_HALF_WIDTH = 66.0
const GUARD_RADIUS = 172.0
const GUARD_POSITIONS = [
	Vector2(-100.0, -580.0), Vector2(100.0, -580.0),
	Vector2(680.0, -100.0), Vector2(680.0, 100.0),
	Vector2(-100.0, 580.0), Vector2(100.0, 580.0),
	Vector2(-680.0, -100.0), Vector2(-680.0, 100.0)
]
const ZONE_GATE_HALF_WIDTH = 120.0
const CASTLE_WALL_THICKNESS = 28.0
const PLAYER_WALL_PADDING = 12.0
const FOUNTAIN_POS = TOWN + Vector2(0, 24)
const SWORD_MERCHANT_POS = TOWN + Vector2(-208, -54)
const BANKER_POS = TOWN + Vector2(115, 305)
const ORACLE_POS = TOWN + Vector2(158, 74)
const ORACLE_TALK_RADIUS = 112.0
const ORACLE_RESPEC_COST = 100
var ORACLE_BUTTON: Rect2 = Rect2(706, 80, 124, 50)
const ORACLE_PANEL = Rect2(210, 122, 540, 297)
const ORACLE_CONFIRM_BUTTON = Rect2(274, 315, 190, 62)
const ORACLE_CANCEL_BUTTON = Rect2(505, 315, 190, 62)
const BANKER_TALK_RADIUS = 110.0
var BANKER_BUTTON: Rect2 = Rect2(706, 80, 124, 50)
var LOOT_BUTTON: Rect2 = Rect2(563, 469, 119, 56)
const LOOT_REACH = 41.0
# Eight vault pages, each as large as the player's 8x5 backpack.
const BANK_PAGES = 8
const BANK_GRID_CELL = 34.0
const BANK_GRID_GAP = 3.0
const BANK_BAG_ORIGIN = Vector2(87, 181)
const BANK_VAULT_ORIGIN = Vector2(573, 181)
const BANK_DEPOSIT_BUTTON = Rect2(358, 217, 112, 46)
const BANK_WITHDRAW_BUTTON = Rect2(358, 274, 112, 46)
const BANK_PREV_BUTTON = Rect2(586, 402, 71, 39)
const BANK_NEXT_BUTTON = Rect2(762, 402, 71, 39)
const BANK_GOLD_DEPOSIT_BUTTON = Rect2(110, 448, 183, 38)
const BANK_GOLD_WITHDRAW_BUTTON = Rect2(618, 448, 204, 38)
const BANK_CLOSE_BUTTON = Rect2(844, 75, 61, 48)
const MERCHANT_TALK_RADIUS = 115.0
var SHOP_BUTTON: Rect2 = Rect2(706, 80, 124, 50)
const SHOP_BUY_BUTTON = Rect2(356, 357, 242, 54)
const SHOP_CLOSE_BUTTON = Rect2(776, 103, 68, 49)
const GOD_SWORD_PRICE = 100
const GOD_SWORD_LIGHTNING_DAMAGE = 18.0
const GOD_SWORD_LIGHTNING_SPEED = 600.0
const GOD_SWORD_LIGHTNING_RANGE = WORLD_TILE_SIZE * 5.0
const FOUNTAIN_HEAL_RADIUS = 74.0
const FOUNTAIN_HEAL_PER_SECOND = 18.0
const ENEMY_CLEARANCE = 18.0
# Red wolves are melee-only; purple bats fire weak ranged projectiles.
const WOLF_BITE_DAMAGE = 16.0
const BAT_BOLT_DAMAGE = 8.0
const BAT_FIRE_INTERVAL = 1.85
const BAT_ATTACK_RANGE = 340.0
const BAT_PREFERRED_DISTANCE = 205.0
const BAT_BOLT_SPEED = 245.0
const WOLF_LEVEL = 5
const BAT_LEVEL = 3
const CAVE_BAT_LEVEL = 10
const CAVE_BAT_HP = 52.0
const CAVE_BAT_DAMAGE = BAT_BOLT_DAMAGE * 2.0
const CAVE_BAT_SCALE = 1.8
const BLOOD_BAT_SUMMON_INTERVAL = 4.0
const BLOOD_BAT_SUMMON_COUNT = 2
const BLOOD_BAT_BOSS_CAP = 8
const BLOOD_BAT_CHAMBER_RADIUS = 420.0
const LEVEL_CAP = 100
const STAT_POINTS_PER_LEVEL = 5
const STAT_KEYS = ["Strength", "Dexterity", "Intellect", "Hitpoints", "Speed", "Luck"]
# Five elixer varieties (Hitpoints remains a level-up stat for now).
const ELIXER_TYPES = ["Strength", "Dexterity", "Intellect", "Speed", "Luck"]
const ELIXER_DROP_CHANCE: float = 0.05
const ELIXER_STACK_MAX = 20
const ELIXER_CONSUME_BUTTON = Rect2(524, 446, 174, 38)
const ELIXER_CONFIRM_YES = Rect2(307, 296, 157, 54)
const ELIXER_CONFIRM_NO = Rect2(496, 296, 157, 54)
var STAT_BUTTON: Rect2 = Rect2(842, 200, 102, 53)
var KNIGHT_ABILITY_BUTTON: Rect2 = Rect2(428, 472, 104, 56)
const KNIGHT_ABILITY_REQUIRED = 50
const KNIGHT_ABILITY_DURATION = 5.0
const BLADESTORM_DURATION = 7.0
const BLADESTORM_TICK = 1.0
const KNIGHT_ABILITY_RADIUS = WORLD_TILE_SIZE * 3.0
const STAT_CLOSE_BUTTON = Rect2(811, 83, 74, 47)
const STAT_PLUS_X = 744.0
const STAT_ROW_START = 174.0
const STAT_ROW_GAP = 45.0
var PORTAL_BUTTON: Rect2 = Rect2(842, 139, 102, 53)
const PORTAL_CAST_TIME = 3.0
const PORTAL_LIFETIME = 15.0
const SANCTUARY_PORTAL_RADIUS = 38.0
const GROUND_DROP_LIFETIME = 30.0
const BLOODY_FOOTPRINT_LIFETIME = 2.0
const BLOODY_FOOTSTEP_DISTANCE = 18.0
const POTION_DROP_CHANCE: float = 0.07
const GOLD_DROP_CHANCE: float = 0.20
const GEAR_DROP_CHANCE: float = 0.04
const WORLD_TILE_SIZE: float = 64.0
const PICKUP_RADIUS: float = WORLD_TILE_SIZE * 3.0
# The Forest's far northeastern cave, kept away from zone boundary crossings.
const FOREST_CAVE_POS = Vector2(FOREST_END - 575.0, FOREST_START + 655.0)
const CAVE_PORTAL_RADIUS = 40.0
const DUNGEON_TILE = 64.0
const DUNGEON_COLS = 36
const DUNGEON_ROWS = 29
const DUNGEON_ENTRY = Vector2(2.5 * DUNGEON_TILE, 25.5 * DUNGEON_TILE)
const DUNGEON_EXIT = Vector2(2.5 * DUNGEON_TILE, 26.5 * DUNGEON_TILE)
const DUNGEON_BOSS_CENTER = Vector2(29.0 * DUNGEON_TILE, 5.0 * DUNGEON_TILE)
const MORVEX_LEVEL = 15
const MORVEX_HP = 1500.0  # Morvex boss maximum HP.
const MORVEX_SONIC_DAMAGE = 80.0  # Raw damage dealt by Morvex sonic waves.
const MORVEX_WAVE_SPEED = 225.0
const MORVEX_WAVE_LANES = 16
const MORVEX_ALT_WAVE_LANES = 12
const MORVEX_WINDUP = 0.45
const MORVEX_WAVE_INTERVAL = 1.8
const MORVEX_XP = 150
const POTION_HEAL_AMOUNT: float = 50.0
var FIRE_CENTER: Vector2 = Vector2(858, 437)
var INVENTORY_BUTTON: Rect2 = Rect2(842, 78, 102, 53)
const FIRE_TOUCH_RADIUS = 105.0
const AIM_DEADZONE = 5.0
const BAG_COLS = 8
const BAG_ROWS = 5
const BAG_ORIGIN = Vector2(489, 154)
const BAG_CELL = 46.0
const BAG_GAP = 2.0
const DESTROY_BUTTON = Rect2(714, 446, 177, 38)
const DESTROY_CONFIRM = Rect2(307, 296, 157, 54)
const DESTROY_CANCEL = Rect2(496, 296, 157, 54)
const EQUIP_NAMES = ["Helmet", "Chest", "Legs", "Weapon", "Offhand", "Cosmetic"]
const EQUIP_KEYS = ["helmet", "chest", "legs", "weapon", "offhand", "cosmetic"]
const EQUIP_POS = [Vector2(237, 157), Vector2(237, 222), Vector2(237, 287), Vector2(114, 240), Vector2(360, 240), Vector2(237, 345)]
var ITEM_DATA = {
 "rusty_sword": {"name":"Rusty Sword", "slot":"weapon", "w":1, "h":2, "atk":4, "def":0, "symbol":"SW", "color":"a9b7c4", "class":0},
 "iron_sword": {"name":"Iron Sword", "slot":"weapon", "w":1, "h":2, "atk":9, "def":0, "symbol":"SW", "color":"c6d6e4", "class":0},
 "iron_greatsword": {"name":"Iron Greatsword (2H)", "slot":"weapon", "w":2, "h":3, "atk":12, "def":0, "symbol":"GS", "color":"c2d0de", "class":0, "two_handed":true},
 "god_sword": {"name":"God Sword", "slot":"weapon", "w":1, "h":3, "atk":20, "def":0, "symbol":"GS", "color":"f9df83", "class":0},
 "oak_shield": {"name":"Oak Shield", "slot":"offhand", "w":2, "h":2, "atk":0, "def":4, "symbol":"SH", "color":"b88758", "class":0},
 "steel_shield": {"name":"Steel Shield", "slot":"offhand", "w":2, "h":2, "atk":0, "def":9, "symbol":"SH", "color":"b3c8dc", "class":0},
 "leather_cap": {"name":"Leather Cap", "slot":"helmet", "w":2, "h":1, "atk":0, "def":2, "symbol":"HM", "color":"a57b54"},
 "iron_helm": {"name":"Iron Helm", "slot":"helmet", "w":2, "h":1, "atk":0, "def":5, "symbol":"HM", "color":"9cabc2"},
 "plate_helm": {"name":"Plate Helm", "slot":"helmet", "w":2, "h":1, "atk":0, "def":8, "symbol":"HM", "color":"d4dce7", "class":0},
 "cloth_robe": {"name":"Cloth Robe", "slot":"chest", "w":2, "h":2, "atk":0, "def":2, "symbol":"CH", "color":"8877ab"},
 "chain_armor": {"name":"Chain Armor", "slot":"chest", "w":2, "h":2, "atk":0, "def":7, "symbol":"CH", "color":"889db7"},
 "plate_chest": {"name":"Plate Chest Armor", "slot":"chest", "w":2, "h":2, "atk":0, "def":12, "symbol":"CH", "color":"c3d1de", "class":0},
 "cloth_pants": {"name":"Cloth Leggings", "slot":"legs", "w":2, "h":2, "atk":0, "def":2, "symbol":"LG", "color":"697fa8"},
 "plate_legs": {"name":"Plate Leggings", "slot":"legs", "w":2, "h":2, "atk":0, "def":9, "symbol":"LG", "color":"adbdd4", "class":0},
 "short_bow": {"name":"Short Bow", "slot":"weapon", "w":2, "h":2, "atk":4, "def":0, "symbol":"BW", "color":"a78255", "class":1},
 "quiver": {"name":"Arrow Quiver", "slot":"offhand", "w":1, "h":2, "atk":2, "def":0, "symbol":"QV", "color":"ad915a", "class":1},
 "apprentice_wand": {"name":"Apprentice Wand", "slot":"weapon", "w":1, "h":2, "atk":4, "def":0, "symbol":"WD", "color":"a89bea", "class":2},
 "spellbook": {"name":"Spellbook", "slot":"offhand", "w":2, "h":1, "atk":2, "def":0, "symbol":"BK", "color":"a68bdb", "class":2},
 "priest_staff": {"name":"Priest Staff", "slot":"weapon", "w":1, "h":3, "atk":3, "def":0, "symbol":"ST", "color":"e9d4a3", "class":3},
 "holy_relic": {"name":"Holy Relic", "slot":"offhand", "w":1, "h":1, "atk":1, "def":1, "symbol":"RL", "color":"e7d17c", "class":3},
 "rogue_dagger": {"name":"Rogue Dagger", "slot":"weapon", "w":1, "h":2, "atk":4, "def":0, "symbol":"DG", "color":"8dd3cc", "class":4},
 "throwing_knife": {"name":"Throwing Knife", "slot":"offhand", "w":1, "h":2, "atk":2, "def":0, "symbol":"KN", "color":"9cc5cb", "class":4},
 "leather_vest": {"name":"Leather Vest", "slot":"chest", "w":2, "h":2, "atk":0, "def":5, "symbol":"CH", "color":"9b7953"},
 "leather_leggings": {"name":"Leather Leggings", "slot":"legs", "w":2, "h":2, "atk":0, "def":4, "symbol":"LG", "color":"987552"},
 "cloth_hood": {"name":"Cloth Hood", "slot":"helmet", "w":2, "h":2, "atk":0, "def":2, "symbol":"HM", "color":"9883bb"},
 "sorcerer_staff": {"name":"Sorcerer Staff (2H)", "slot":"weapon", "w":1, "h":4, "atk":7, "def":0, "symbol":"ST", "color":"8ca9ef", "class":2, "two_handed":true},
 "cleric_sceptre": {"name":"Holy Sceptre (2H)", "slot":"weapon", "w":1, "h":4, "atk":7, "def":0, "symbol":"SC", "color":"e2c881", "class":3, "two_handed":true},
 "cleric_mace": {"name":"Cleric Mace", "slot":"weapon", "w":1, "h":3, "atk":5, "def":0, "symbol":"MC", "color":"dccaa0", "class":3},
 "holy_book": {"name":"Holy Book", "slot":"offhand", "w":2, "h":2, "atk":2, "def":0, "symbol":"BK", "color":"e0ca88", "class":3},
 "rogue_offhand_dagger": {"name":"Rogue Offhand Dagger", "slot":"offhand", "w":1, "h":3, "atk":3, "def":0, "symbol":"DG", "color":"85c8c1", "class":4}
}
const WARRIOR_SWING_DURATION = 0.18
const WARRIOR_SWING_RANGE = 82.0
const WARRIOR_SWING_ARC_DEGREES = 180.0

var slots: Array = []
var active_slot := -1
var player := TOWN
var hp := 100.0
var max_hp := 100.0
var attack_cooldown := 0.0
var invulnerable := 0.0
var dead_timer := 0.0
var spawn_timer := 0.0
var save_timer := 0.0
var projectiles: Array = []
var enemy_projectiles: Array = []
var enemies: Array = []
var drops: Array = []
var cosmetic_footprints: Array = []
var world_rng := RandomNumberGenerator.new()
var left_touch := -1
var right_touch := -1
var joystick_origin := Vector2.ZERO
var joystick_current := Vector2.ZERO
var aim_point := Vector2.ZERO
var fire_stick_mode := false
var fire_stick_origin := Vector2.ZERO
var fire_stick_position := Vector2.ZERO
var facing_direction := Vector2.UP
var pointer_held := false
var mobile_fire := false
var kills := 0
var status_message := ""
var status_timer := 0.0
var warrior_swing_timer := 0.0
var warrior_swing_direction := Vector2.UP
var warrior_slash_flash := 0.0
var inventory_open := false
var shop_open := false
var bank_open := false
var oracle_open := false
var bank_page := 0
var bank_selected_bag := -1
var bank_selected_vault := -1
var selected_bag_index := -1
var destroy_confirmation := false
var elixer_confirmation := false
var loot_counter := 0
var fountain_heal_notice := 0.0
var lightning_clock := 0.0
# Short-lived floating HP numbers (damage red, healing green).
var combat_texts: Array = []
var fountain_heal_accumulator := 0.0
const DAMAGE_COLOR = Color("fa565d")
const CRIT_CHANCE: float = 0.10
const CRIT_DAMAGE_MULTIPLIER: float = 1.70
const CRIT_COLOR = Color("ffdc65")
const HEAL_COLOR = Color("5deb76")
var portal_cast_timer := 0.0
var portal_origin := Vector2.ZERO
var portal_cast_in_dungeon := false
var sanctuary_portal_time := 0.0
var sanctuary_portal_pos := Vector2.ZERO
var sanctuary_portal_in_dungeon := false
var sanctuary_portal_requires_exit := false
var footprint_last_pos := Vector2.ZERO
var footprint_left_step := true
var footprint_distance_walked := 0.0
var stat_window_open := false
var knight_ability_charge := 0
var knight_ability_timer := 0.0
var knight_ability_spin := 0.0
var bladestorm_charge := 0
var bladestorm_timer := 0.0
var bladestorm_tick_timer := 0.0
var bladestorm_spin := 0.0

var road_segments: Array = []
var road_tile_lookup: Dictionary = {}
var current_zone_id := 0
# The cave is an isolated scene instance, not another overworld region.
var dungeon_active := false
var dungeon_walkable: Dictionary = {}
var cave_portal_cooldown := 0.0
var morvex_wave_pattern := 0
var morvex_attack_style := 0
var morvex_windup_timer := 0.0
var morvex_attack_cooldown := 0.0
var morvex_attack_telegraph := -1
var morvex_defeated := false
var blood_bat_spawn_timer := 0.0

var lightning_impacts: Array = []
var guard_attack_flash := [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var reset_slot_pending := -1
var preview_slot := 0
const CHARACTER_PLAY_BUTTON = Rect2(637, 452, 225, 57)
const CHARACTER_SELECT_ORIGIN = Vector2(53, 147)
const CHARACTER_SELECT_STEP = 67.0
const CHARACTER_SELECT_ROW_SIZE = Vector2(393, 57)
const CHARACTER_PREVIEW_PANEL = Rect2(579, 136, 336, 300)
const RESET_CONFIRM_RECT = Rect2(326, 316, 142, 50)
const RESET_CANCEL_RECT = Rect2(493, 316, 142, 50)

func refresh_adaptive_layout() -> void:
	# Expand keeps the 540-high world scale; on wide phones the logical
	# canvas is wider instead of adding black bars or stretching sprites.
	var actual: Vector2 = get_viewport_rect().size
	if actual.x < 1.0 or actual.y < 1.0:
		return
	VIEW = actual
	var dx: float = VIEW.x - DESIGN_VIEW.x
	var dy: float = VIEW.y - DESIGN_VIEW.y
	var right: Vector2 = Vector2(dx, 0.0)
	var centered_bottom: Vector2 = Vector2(dx * 0.5, dy)
	FIRE_CENTER = Vector2(858, 437) + Vector2(dx, dy)
	INVENTORY_BUTTON = Rect2(Vector2(842, 78) + right, Vector2(102, 53))
	PORTAL_BUTTON = Rect2(Vector2(842, 139) + right, Vector2(102, 53))
	STAT_BUTTON = Rect2(Vector2(842, 200) + right, Vector2(102, 53))
	BANKER_BUTTON = Rect2(Vector2(706, 80) + right, Vector2(124, 50))
	ORACLE_BUTTON = Rect2(Vector2(706, 80) + right, Vector2(124, 50))
	SHOP_BUTTON = Rect2(Vector2(706, 80) + right, Vector2(124, 50))
	KNIGHT_ABILITY_BUTTON = Rect2(Vector2(428, 472) + centered_bottom, Vector2(104, 56))
	LOOT_BUTTON = Rect2(Vector2(563, 469) + centered_bottom, Vector2(119, 56))
	queue_redraw()

func _ready() -> void:
	refresh_adaptive_layout()
	get_viewport().size_changed.connect(refresh_adaptive_layout)
	world_rng.seed = 20261107
	init_item_tiers()
	init_elixer_items()
	init_cosmetic_items()
	build_wilderness_roads()
	build_dungeon_layout()
	load_slots()
	set_process(true)
	queue_redraw()

func default_slot(index: int) -> Dictionary:
	var starter_weapons: Array = ["rusty_sword", "short_bow", "apprentice_wand", "cleric_mace", "rogue_dagger"]
	var starter_offhands: Array = ["oak_shield", "quiver", "spellbook", "holy_book", "rogue_offhand_dagger"]
	return {"class": CLASSES[index], "level": 1, "xp": 0, "gold": 0, "kills": 0,
		"stats": {"Strength": 0, "Dexterity": 0, "Intellect": 0, "Hitpoints": 0, "Speed": 0, "Luck": 0},
		"stat_points": 0,
		"level_stats": {"Strength": 0, "Dexterity": 0, "Intellect": 0, "Hitpoints": 0, "Speed": 0, "Luck": 0},
		"elixer_stats": {"Strength": 0, "Dexterity": 0, "Intellect": 0, "Hitpoints": 0, "Speed": 0, "Luck": 0},
		"legacy_stats": {"Strength": 0, "Dexterity": 0, "Intellect": 0, "Hitpoints": 0, "Speed": 0, "Luck": 0},
		"bank_gold": 0, "bank_items": [],
		"bag": [],
		"equipment": {"weapon": starter_weapons[index], "offhand": starter_offhands[index],
		"helmet": "", "chest": "", "legs": "", "cosmetic": ""}}

func item_base_id(item_id: String) -> String:
	return item_id.substr(0, item_id.length() - 3) if item_id.ends_with("_t2") else item_id

func init_item_tiers() -> void:
	if ITEM_DATA.has("rusty_sword_t2"):
		return
	var base_keys: Array = ITEM_DATA.keys()
	for key_variant in base_keys:
		var key: String = str(key_variant)
		var tier_one: Dictionary = ITEM_DATA[key]
		tier_one = tier_one.duplicate(true)
		tier_one["tier"] = 1
		tier_one["name"] = str(tier_one["name"]) + " T1"
		# Weapons and offensive offhands give ATK + CRIT. Shields and armor give DEF + HP.
		# Two-handed weapon support is data-driven for future weapon designs.
		if int(tier_one.get("atk", 0)) > 0:
			# The unique God Sword has +10% CRIT, unlike normal T1 one-handers.
			tier_one["crit"] = 10.0 if key == "god_sword" else (8.0 if bool(tier_one.get("two_handed", false)) else 5.0)
			tier_one["hp"] = 0
		else:
			tier_one["crit"] = 0.0
			tier_one["hp"] = int(round(float(int(tier_one.get("def", 0))) * 0.30))
		# Inventory cell sizing: two-handed weapon 1x4, one-handed weapon
		# 1x3, armor and shields 2x2 (all four squares).
		# Applies to every tier because T2 duplicates the T1 definition.
		var gear_slot: String = str(tier_one.get("slot", ""))
		if gear_slot == "weapon":
			tier_one["w"] = 1
			tier_one["h"] = 4 if bool(tier_one.get("two_handed", false)) else 3
		elif gear_slot == "helmet" or gear_slot == "chest" or gear_slot == "legs":
			tier_one["w"] = 2
			tier_one["h"] = 2
		elif item_base_id(key).ends_with("shield"):
			tier_one["w"] = 2
			tier_one["h"] = 2
		ITEM_DATA[key] = tier_one
	for key_variant in base_keys:
		var key: String = str(key_variant)
		# The God Sword is a unique Tier 1 weapon; it has no Tier 2 version.
		if key == "god_sword":
			continue
		var tier_source: Dictionary = ITEM_DATA[key]
		tier_source = tier_source.duplicate(true)
		var tier_two: Dictionary = tier_source.duplicate(true)
		tier_two["tier"] = 2
		tier_two["name"] = str(tier_source["name"]).replace(" T1", " T2")
		tier_two["atk"] = int(round(float(int(tier_source.get("atk", 0))) * 1.2))
		tier_two["def"] = int(round(float(int(tier_source.get("def", 0))) * 1.2))
		if int(tier_two.get("atk", 0)) > 0:
			tier_two["crit"] = float(tier_source.get("crit", 5.0)) * 1.2
			tier_two["hp"] = 0
		else:
			tier_two["crit"] = 0.0
			tier_two["hp"] = int(round(float(int(tier_two.get("def", 0))) * 0.30))
		ITEM_DATA[key + "_t2"] = tier_two

func init_elixer_items() -> void:
	# Elixers are consumables, never tiered weapons or armor.
	var colors: Array = ["e6ebf2", "52d477", "4589ed", "f4dc56", "b273ed"]
	for i in range(ELIXER_TYPES.size()):
		var stat_name: String = str(ELIXER_TYPES[i])
		var elixer_id: String = "elixer_" + stat_name.to_lower()
		ITEM_DATA[elixer_id] = {"name": "Elixer of " + stat_name,
			"slot": "consumable", "w": 1, "h": 1, "atk": 0,
			"def": 0, "hp": 0, "crit": 0.0, "tier": 0,
			"symbol": "EX", "color": str(colors[i]), "stat": stat_name}

func init_cosmetic_items() -> void:
	# Cosmetic items do not give damage, defense, critical chance, or health.
	# Registered separately after tier generation so there is no Tier 2 cosmetic.
	ITEM_DATA["bloody_footprints"] = {"name": "Bloody Footprints", "slot": "cosmetic",
		"w": 2, "h": 2, "atk": 0, "def": 0, "hp": 0, "crit": 0.0,
		"tier": 0, "symbol": "BF", "color": "6b1d25"}

func is_elixer(item_id: String) -> bool:
	return item_id.begins_with("elixer_") and ITEM_DATA.has(item_id)

func stack_count(item: Dictionary) -> int:
	return maxi(1, int(item.get("count", 1)))

func item_quantity_label(item: Dictionary) -> String:
	return "x%d" % stack_count(item) if is_elixer(str(item.get("id", ""))) else ""

func item_tier(item_id: String) -> int:
	var definition: Dictionary = ITEM_DATA.get(item_id, {})
	return int(definition.get("tier", 1))

func item_border_color(item_id: String) -> Color:
	return Color("55d36a") if item_tier(item_id) >= 2 else Color("f2f5f7")

func gear_stat_label(definition: Dictionary) -> String:
	if int(definition.get("atk", 0)) > 0:
		return "ATK +%d  CRIT +%.1f%%" % [int(definition.get("atk", 0)), float(definition.get("crit", 0.0))]
	return "DEF +%d  HP +%d" % [int(definition.get("def", 0)), int(definition.get("hp", 0))]

func player_crit_chance() -> float:
	return clampf(CRIT_CHANCE + float(get_equipment_bonus("crit")) / 100.0, 0.0, 1.0)

func refresh_equipment_hp(old_maximum: float) -> void:
	max_hp = character_max_hp()
	# Equipping adds its bonus immediately; unequipping cannot leave HP above max.
	hp = clampf(hp + maxf(0.0, max_hp - old_maximum), 0.0, max_hp)

func layout_position_available(existing: Array, page: int, x: int, y: int, w: int, h: int) -> bool:
	if x < 0 or y < 0 or x + w > BAG_COLS or y + h > BAG_ROWS:
		return false
	for existing_var in existing:
		var prior: Dictionary = existing_var
		if int(prior.get("page", 0)) != page:
			continue
		var definition: Dictionary = ITEM_DATA.get(str(prior.get("id", "")), {})
		if definition.is_empty():
			continue
		var px: int = int(prior.get("x", 0))
		var py: int = int(prior.get("y", 0))
		if x < px + int(definition["w"]) and x + w > px and y < py + int(definition["h"]) and y + h > py:
			return false
	return true

func layout_free_position(existing: Array, item_id: String, preferred_page: int, px: int, py: int, bank_layout: bool) -> Vector3i:
	var def: Dictionary = ITEM_DATA[item_id]
	var w: int = int(def["w"])
	var h: int = int(def["h"])
	if layout_position_available(existing, preferred_page, px, py, w, h):
		return Vector3i(preferred_page, px, py)
	var pages: int = BANK_PAGES if bank_layout else 1
	for pg in range(pages):
		for y in range(BAG_ROWS):
			for x in range(BAG_COLS):
				if layout_position_available(existing, pg, x, y, w, h):
					return Vector3i(pg, x, y)
	return Vector3i(-1, -1, -1)

func reflow_saved_inventory(slot_index: int) -> void:
	var old_vault: Array = slots[slot_index]["bank_items"]
	var old_bag: Array = slots[slot_index]["bag"]
	var new_vault: Array = []
	var new_bag: Array = []
	var spill: Array = []
	# Bank items are packed in their eight existing vault pages.
	for value in old_vault:
		if typeof(value) != TYPE_DICTIONARY:
			continue
		var item: Dictionary = value
		var id: String = str(item.get("id", ""))
		if not ITEM_DATA.has(id):
			continue
		var page: int = clampi(int(item.get("page", 0)), 0, BANK_PAGES - 1)
		var pos: Vector3i = layout_free_position(new_vault, id, page, int(item.get("x", 0)), int(item.get("y", 0)), true)
		if pos.x >= 0:
			var placed: Dictionary = item.duplicate()
			placed["page"] = pos.x
			placed["x"] = pos.y
			placed["y"] = pos.z
			new_vault.append(placed)
		else:
			spill.append(item)
	for value in old_bag:
		if typeof(value) != TYPE_DICTIONARY:
			continue
		var item: Dictionary = value
		var id: String = str(item.get("id", ""))
		if not ITEM_DATA.has(id):
			continue
		var pos: Vector3i = layout_free_position(new_bag, id, 0, int(item.get("x", 0)), int(item.get("y", 0)), false)
		if pos.x >= 0:
			var placed: Dictionary = item.duplicate()
			placed.erase("page")
			placed["x"] = pos.y
			placed["y"] = pos.z
			new_bag.append(placed)
		else:
			spill.append(item)
	# Keep extra old backpack pieces safely in the Banker if expansion fills the bag.
	for item in spill:
		var id: String = str(item["id"])
		var pos: Vector3i = layout_free_position(new_vault, id, 0, -1, -1, true)
		if pos.x >= 0:
			var placed: Dictionary = item.duplicate()
			placed["page"] = pos.x
			placed["x"] = pos.y
			placed["y"] = pos.z
			new_vault.append(placed)
		else:
			# No item is silently discarded even for an unusually full legacy save.
			# Keep the original item accessible rather than losing valuable equipment.
			var retained: Dictionary = item.duplicate()
			retained.erase("page")
			new_bag.append(retained)
	slots[slot_index]["bank_items"] = new_vault
	slots[slot_index]["bag"] = new_bag

func load_slots() -> void:
	for i in range(CLASSES.size()):
		slots.append(default_slot(i))
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if f == null:
		return
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	if typeof(parsed) != TYPE_ARRAY or parsed.size() != CLASSES.size():
		return
	for i in range(CLASSES.size()):
		if typeof(parsed[i]) != TYPE_DICTIONARY:
			continue
		for field in ["level", "xp", "gold", "kills"]:
			if parsed[i].has(field):
				slots[i][field] = maxi(0, int(parsed[i][field]))
		slots[i]["level"] = clampi(int(slots[i]["level"]), 1, LEVEL_CAP)
		# Keep individual stat sources separate. Existing saves from versions
		# before v33 cannot identify which old points came from Elixers.
		# Protect their preexisting allocations as legacy stats, never erase
		# them during a reset. New level and Elixer allocations are tracked.
		var earned_points: int = (int(slots[i]["level"]) - 1) * STAT_POINTS_PER_LEVEL
		var has_source_ledger: bool = parsed[i].has("level_stats") and parsed[i].has("elixer_stats") and parsed[i].has("legacy_stats")
		if has_source_ledger:
			var stored_levels: Dictionary = parsed[i]["level_stats"] if typeof(parsed[i]["level_stats"]) == TYPE_DICTIONARY else {}
			var stored_elixers: Dictionary = parsed[i]["elixer_stats"] if typeof(parsed[i]["elixer_stats"]) == TYPE_DICTIONARY else {}
			var stored_legacy: Dictionary = parsed[i]["legacy_stats"] if typeof(parsed[i]["legacy_stats"]) == TYPE_DICTIONARY else {}
			for key in STAT_KEYS:
				slots[i]["level_stats"][key] = maxi(0, int(stored_levels.get(key, 0)))
				slots[i]["elixer_stats"][key] = maxi(0, int(stored_elixers.get(key, 0)))
				slots[i]["legacy_stats"][key] = maxi(0, int(stored_legacy.get(key, 0)))
				slots[i]["stats"][key] = int(slots[i]["level_stats"][key]) + int(slots[i]["elixer_stats"][key]) + int(slots[i]["legacy_stats"][key])
			slots[i]["stat_points"] = maxi(0, int(parsed[i].get("stat_points", earned_points)))
		elif parsed[i].has("stats") and typeof(parsed[i]["stats"]) == TYPE_DICTIONARY:
			var old_stats: Dictionary = parsed[i]["stats"]
			var total_previous_points: int = 0
			for key in STAT_KEYS:
				var previous: int = maxi(0, int(old_stats.get(key, 0)))
				slots[i]["stats"][key] = previous
				slots[i]["legacy_stats"][key] = previous
				total_previous_points += previous
			# Preserve the previous unspent count when available. Older
			# builds included this value in JSON but sometimes recalculated it.
			slots[i]["stat_points"] = maxi(0, int(parsed[i].get("stat_points", maxi(0, earned_points - total_previous_points))))
		else:
			slots[i]["stat_points"] = earned_points
		if int(slots[i]["level"]) >= LEVEL_CAP:
			slots[i]["xp"] = 0
		if parsed[i].has("bank_gold"):
			slots[i]["bank_gold"] = maxi(0, int(parsed[i]["bank_gold"]))
		if parsed[i].has("bank_items") and typeof(parsed[i]["bank_items"]) == TYPE_ARRAY:
			# Eight pages with the same item dimensions as a regular backpack.
			for saved_item in parsed[i]["bank_items"]:
				if typeof(saved_item) == TYPE_DICTIONARY:
					var entry: Dictionary = saved_item
					var entry_id: String = str(entry.get("id", ""))
					if entry_id == "god_sword_t2":
						entry_id = "god_sword"
					if entry_id == "bat_wings":
						entry_id = "bloody_footprints"
					if ITEM_DATA.has(entry_id):
						slots[i]["bank_items"].append({"id": entry_id, "x": int(entry.get("x", 0)), "y": int(entry.get("y", 0)), "page": clampi(int(entry.get("page", 0)), 0, BANK_PAGES - 1), "count": clampi(int(entry.get("count", 1)), 1, ELIXER_STACK_MAX) if is_elixer(entry_id) else 1})
		if parsed[i].has("bag") and typeof(parsed[i]["bag"]) == TYPE_ARRAY:
			slots[i]["bag"] = parsed[i]["bag"]
		if parsed[i].has("equipment") and typeof(parsed[i]["equipment"]) == TYPE_DICTIONARY:
			for key in EQUIP_KEYS:
				if parsed[i]["equipment"].has(key):
					slots[i]["equipment"][key] = parsed[i]["equipment"][key]
		# Keep existing character saves valid if an old version had granted a
		# God Sword T2. Convert those old IDs to the sole Tier 1 God Sword.
		for bag_item in slots[i]["bag"]:
			if typeof(bag_item) == TYPE_DICTIONARY:
				if str(bag_item.get("id", "")) == "god_sword_t2":
					bag_item["id"] = "god_sword"
				elif str(bag_item.get("id", "")) == "bat_wings":
					bag_item["id"] = "bloody_footprints"
		# Preserve all progress when legacy Wizard/Priest slots are renamed.
		slots[i]["class"] = CLASSES[i]
		var old_ids: Dictionary = {"priest_staff": "cleric_mace", "holy_relic": "holy_book", "throwing_knife": "rogue_offhand_dagger"}
		for bag_item in slots[i]["bag"]:
			if typeof(bag_item) == TYPE_DICTIONARY:
				var saved_id: String = str(bag_item.get("id", ""))
				var tier_tag: String = "_t2" if saved_id.ends_with("_t2") else ""
				var root_id: String = item_base_id(saved_id)
				if old_ids.has(root_id):
					bag_item["id"] = str(old_ids[root_id]) + tier_tag
		for bank_item in slots[i]["bank_items"]:
			var saved_id: String = str(bank_item.get("id", ""))
			var tier_tag: String = "_t2" if saved_id.ends_with("_t2") else ""
			var root_id: String = item_base_id(saved_id)
			if old_ids.has(root_id):
				bank_item["id"] = str(old_ids[root_id]) + tier_tag
		for equip_key in EQUIP_KEYS:
			var saved_id: String = str(slots[i]["equipment"].get(equip_key, ""))
			if saved_id == "god_sword_t2":
				slots[i]["equipment"][equip_key] = "god_sword"
			elif saved_id == "bat_wings":
				slots[i]["equipment"][equip_key] = "bloody_footprints"
			else:
				var tier_tag: String = "_t2" if saved_id.ends_with("_t2") else ""
				var root_id: String = item_base_id(saved_id)
				if old_ids.has(root_id):
					slots[i]["equipment"][equip_key] = str(old_ids[root_id]) + tier_tag
		reflow_saved_inventory(i)
	footprint_last_pos = player

func save_slots() -> void:
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f != null:
		f.store_string(JSON.stringify(slots))

func handle_character_menu_tap(pos: Vector2) -> void:
	if reset_slot_pending != -1:
		if RESET_CONFIRM_RECT.has_point(pos):
			var index: int = reset_slot_pending
			slots[index] = default_slot(index)
			preview_slot = index
			reset_slot_pending = -1
			save_slots()
		elif RESET_CANCEL_RECT.has_point(pos):
			reset_slot_pending = -1
		queue_redraw()
		return
	for i in range(CLASSES.size()):
		var reset_button: Rect2 = Rect2(457, 154 + float(i) * CHARACTER_SELECT_STEP, 104, 43)
		if reset_button.has_point(pos):
			reset_slot_pending = i
			queue_redraw()
			return
	if CHARACTER_PLAY_BUTTON.has_point(pos):
		select_slot(preview_slot)
		return
	choose_from_position(pos)
	queue_redraw()

func select_slot(index: int) -> void:
	if index < 0 or index >= CLASSES.size():
		return
	active_slot = index
	shop_open = false
	bank_open = false
	oracle_open = false
	bank_page = 0
	bank_selected_bag = -1
	bank_selected_vault = -1
	inventory_open = false
	selected_bag_index = -1
	destroy_confirmation = false
	player = TOWN
	cosmetic_footprints.clear()
	footprint_last_pos = player
	footprint_distance_walked = 0.0
	footprint_left_step = true
	dungeon_active = false
	cave_portal_cooldown = 0.0
	morvex_windup_timer = 0.0
	morvex_attack_cooldown = 0.0
	morvex_attack_telegraph = -1
	morvex_attack_style = 0
	blood_bat_spawn_timer = 0.0
	morvex_defeated = false
	current_zone_id = 0
	facing_direction = Vector2.UP
	warrior_swing_direction = Vector2.UP
	warrior_swing_timer = 0.0
	warrior_slash_flash = 0.0
	portal_cast_timer = 0.0
	clear_sanctuary_portal()
	knight_ability_charge = 0
	knight_ability_timer = 0.0
	knight_ability_spin = 0.0
	bladestorm_charge = 0
	bladestorm_timer = 0.0
	bladestorm_tick_timer = 0.0
	bladestorm_spin = 0.0
	stat_window_open = false
	left_touch = -1
	right_touch = -1
	mobile_fire = false
	fire_stick_mode = false
	fire_stick_origin = Vector2.ZERO
	fire_stick_position = Vector2.ZERO
	pointer_held = false
	max_hp = character_max_hp()
	hp = max_hp
	attack_cooldown = 0.0
	dead_timer = 0.0
	invulnerable = 1.0
	enemies.clear()
	projectiles.clear()
	enemy_projectiles.clear()
	drops.clear()
	combat_texts.clear()
	fountain_heal_accumulator = 0.0
	kills = int(slots[index]["kills"])
	status_message = "Sanctuary is protected — monsters cannot enter!"
	status_timer = 3.0
	queue_redraw()

# Rectangular sanctuary with drawbridges on all four cardinal sides.
func castle_rect() -> Rect2:
	return Rect2(TOWN - CASTLE_HALF, CASTLE_HALF * 2.0)

func is_in_sanctuary(pos: Vector2) -> bool:
	return castle_rect().has_point(pos)

func north_bridge_start() -> Vector2:
	return TOWN + Vector2(0.0, -CASTLE_HALF.y - 68.0)

func east_bridge_start() -> Vector2:
	return TOWN + Vector2(CASTLE_HALF.x + 68.0, 0.0)

func south_bridge_start() -> Vector2:
	return TOWN + Vector2(0.0, CASTLE_HALF.y + 68.0)

func west_bridge_start() -> Vector2:
	return TOWN + Vector2(-CASTLE_HALF.x - 68.0, 0.0)

func north_zone_gate() -> Vector2:
	return Vector2(TOWN.x, FOREST_START)

func east_zone_gate() -> Vector2:
	return Vector2(FOREST_END, TOWN.y)

func south_zone_gate() -> Vector2:
	return Vector2(TOWN.x, FOREST_END)

func west_zone_gate() -> Vector2:
	return Vector2(FOREST_START, TOWN.y)

func is_on_vertical_gate_lane(pos: Vector2) -> bool:
	return absf(pos.x - TOWN.x) < CASTLE_GATE_HALF_WIDTH - PLAYER_WALL_PADDING

func is_on_horizontal_gate_lane(pos: Vector2) -> bool:
	return absf(pos.y - TOWN.y) < CASTLE_GATE_HALF_WIDTH - PLAYER_WALL_PADDING

func is_on_drawbridge(pos: Vector2) -> bool:
	return is_on_vertical_gate_lane(pos) or is_on_horizontal_gate_lane(pos)

# ID: 0 Forest; 1 Desert; 2 Mountains; 3 Haunted Jungle; 4 Volcano;
# -1 is outside all five regions (the unused diagonal corners).
func zone_id_at(pos: Vector2) -> int:
	var column: int = int(floor(pos.x / ZONE_SIZE))
	var row_index: int = int(floor(pos.y / ZONE_SIZE))
	if column == 1 and row_index == 1:
		return 0
	if column == 2 and row_index == 1:
		return 1
	if column == 1 and row_index == 0:
		return 2
	if column == 0 and row_index == 1:
		return 3
	if column == 1 and row_index == 2:
		return 4
	return -1

func zone_name(zone_id: int) -> String:
	match zone_id:
		0:
			return "The Forest"
		1:
			return "The Desert"
		2:
			return "The Mountains"
		3:
			return "Haunted Jungle"
		4:
			return "The Volcano"
	return "Uncharted"

func is_playable_ground(pos: Vector2) -> bool:
	return zone_id_at(pos) >= 0

func terrain_color(zone_id: int, variant: int, road: bool) -> Color:
	if road:
		match zone_id:
			1: return Color("cba56a") if variant < 4 else Color("deb879")
			2: return Color("8d9eac") if variant < 4 else Color("a3b4bf")
			3: return Color("54664b") if variant < 4 else Color("667b55")
			4: return Color("665044") if variant < 4 else Color("7b5c4a")
		return Color("8f7651") if variant < 4 else Color("9e845d")
	match zone_id:
		1: return Color("d7b475") if variant < 4 else Color("e4c58a")
		2: return Color("bdcfda") if variant < 4 else Color("e1eaf0")
		3: return Color("244f43") if variant < 4 else Color("315b4a")
		4: return Color("37313c") if variant < 4 else Color("4a3c40")
	return Color("365c42") if variant < 4 else Color("3d6649")

# Deterministic details make each region visibly distinct without loading
# thousands of scene nodes or creating huge map textures on Android.
func draw_biome_detail(top_left: Vector2, tile_x: int, tile_y: int, zone_id: int, on_road: bool) -> void:
	var seed_value: int = absi(tile_x * 928371 + tile_y * 523543 + tile_x * tile_x * 83 + tile_y * tile_y * 97 + tile_x * tile_y * 61)
	var detail: int = seed_value % 13
	if zone_id == 0 and (top_left + Vector2(32, 32)).distance_squared_to(FOREST_CAVE_POS) < 230.0 * 230.0:
		return
	if on_road:
		if detail == 1 or detail == 6:
			draw_rect(Rect2(top_left + Vector2(12, 29), Vector2(20, 4)), Color("69533c", 0.5))
		return
	match zone_id:
		0:
			# Forest flora is intentionally lighter and more irregular now, to avoid
			# obvious grid rows of trees. These remain purely decorative.
			var placement_roll: int = seed_value % 100
			if placement_roll >= 27:
				return
			var jitter_x: float = float((seed_value / 19) % 32) - 16.0
			var jitter_y: float = float((seed_value / 37) % 26) - 13.0
			var center: Vector2 = top_left + Vector2(32 + jitter_x, 34 + jitter_y)
			var foliage_shift: float = float((seed_value / 11) % 5)
			if placement_roll < 7:
				# Wide broadleaf oak with an irregular layered crown.
				draw_rect(Rect2(center + Vector2(-5, -2), Vector2(10, 28)), Color("705136"))
				draw_circle(center + Vector2(-15, -10), 18, Color("2b4d2d"))
				draw_circle(center + Vector2(10, -16), 16, Color("3b6f39"))
				draw_circle(center + Vector2(-2, -27), 20, Color("4f8442"))
				draw_circle(center + Vector2(9, -28), 11, Color("7ea35a", 0.60))
			elif placement_roll < 12:
				# Pine tree with more varied triangle widths.
				draw_rect(Rect2(center + Vector2(-4, 2), Vector2(8, 27)), Color("68482c"))
				for layer in range(3):
					var yy: float = -29.0 + float(layer) * 12.0
					var span: float = 14.0 + float(layer) * 8.0 + (foliage_shift if layer == 1 else 0.0)
					draw_colored_polygon(PackedVector2Array([center + Vector2(0, yy), center + Vector2(-span, yy + 21), center + Vector2(span, yy + 21)]), Color("27553d") if layer == 0 else Color("316d46"))
			elif placement_roll < 15:
				# Sparse birch.
				draw_rect(Rect2(center + Vector2(-3, -18), Vector2(6, 42)), Color("d3c79e"))
				draw_rect(Rect2(center + Vector2(-3, -6), Vector2(3, 4)), Color("4d5543"))
				draw_circle(center + Vector2(-6, -22), 11, Color("7fa15b"))
				draw_circle(center + Vector2(9, -24), 13, Color("9db96e"))
				draw_circle(center + Vector2(0, -33), 12, Color("719b5b"))
			elif placement_roll < 21:
				# Bush clusters, ferns and berry shrubs.
				draw_circle(center + Vector2(-8, 1), 10, Color("315c36"))
				draw_circle(center + Vector2(6, -2), 12, Color("4f8142"))
				draw_circle(center + Vector2(0, -7), 9, Color("75a555"))
				if placement_roll >= 18:
					for berry in [Vector2(-5, -3), Vector2(6, -5), Vector2(1, 4)]:
						draw_circle(center + berry, 2.2, Color("c75c51"))
			elif placement_roll < 24:
				# Stump and fern.
				draw_rect(Rect2(center + Vector2(-6, 2), Vector2(12, 12)), Color("6e5036"))
				draw_circle(center + Vector2(0, 2), 7, Color("ae8c57"))
				draw_line(center + Vector2(12, 12), center + Vector2(15, -5), Color("4f9047"), 3)
				draw_line(center + Vector2(12, 12), center + Vector2(20, 4), Color("4f9047"), 2)
			else:
				# Young sapling.
				draw_line(center + Vector2(0, 16), center + Vector2(0, -9), Color("76613d"), 4)
				draw_circle(center + Vector2(-5, -10), 9, Color("5c914e"))
				draw_circle(center + Vector2(7, -14), 9, Color("7ca65a"))
		1:
			if detail == 0 or detail == 8:
				# Cactus and its shadow.
				draw_rect(Rect2(top_left + Vector2(24, 13), Vector2(8, 29)), Color("39836e"))
				draw_rect(Rect2(top_left + Vector2(19, 22), Vector2(6, 7)), Color("39836e"))
				draw_rect(Rect2(top_left + Vector2(29, 25), Vector2(7, 6)), Color("39836e"))
				draw_rect(Rect2(top_left + Vector2(22, 42), Vector2(13, 5)), Color("000000", 0.12))
			elif detail == 3:
				draw_colored_polygon(PackedVector2Array([top_left + Vector2(13, 47), top_left + Vector2(24, 20), top_left + Vector2(37, 47)]), Color("ab8f5e"))
		2:
			if detail == 1 or detail == 7:
				draw_rect(Rect2(top_left + Vector2(17, 37), Vector2(30, 9)), Color("d5e2eb", 0.85))
				draw_circle(top_left + Vector2(30, 23), 12, Color("f3fbff"))
			elif detail == 4:
				draw_rect(Rect2(top_left + Vector2(27, 8), Vector2(10, 34)), Color("6b7f83"))
				draw_circle(top_left + Vector2(32, 10), 16, Color("e6f4fb", 0.88))
		3:
			if detail == 0 or detail == 6:
				draw_circle(top_left + Vector2(24, 28), 15, Color("4a7f47"))
				draw_circle(top_left + Vector2(39, 26), 12, Color("5ca04f"))
				draw_circle(top_left + Vector2(32, 14), 13, Color("7c42a0"))
			elif detail == 9:
				draw_rect(Rect2(top_left + Vector2(30, 10), Vector2(5, 28)), Color("5c814f"))
				draw_circle(top_left + Vector2(25, 11), 9, Color("6cba6a"))
				draw_circle(top_left + Vector2(40, 11), 9, Color("754ab4"))
		4:
			if detail == 2 or detail == 7:
				draw_colored_polygon(PackedVector2Array([top_left + Vector2(17, 44), top_left + Vector2(32, 20), top_left + Vector2(45, 44)]), Color("ff7446"))
				draw_circle(top_left + Vector2(31, 24), 9, Color("ffb04d"))
			elif detail == 10:
				draw_rect(Rect2(top_left + Vector2(7, 47), Vector2(46, 6)), Color("4f3332", 0.8))
				draw_circle(top_left + Vector2(20, 28), 7, Color("ff7446", 0.55))
				draw_circle(top_left + Vector2(38, 31), 5, Color("ffcc6a", 0.48))

func append_winding_road(waypoints: Array, route_index: int) -> void:
	for i in range(waypoints.size() - 1):
		var first: Vector2 = Vector2(waypoints[i])
		var last: Vector2 = Vector2(waypoints[i + 1])
		var segment: Vector2 = last - first
		var length: float = segment.length()
		if length < 0.01:
			continue
		var tangent: Vector2 = segment / length
		var normal: Vector2 = Vector2(-tangent.y, tangent.x)
		var steps: int = maxi(2, int(ceil(length / 52.0)))
		var prev: Vector2 = first
		for step in range(1, steps + 1):
			var t: float = float(step) / float(steps)
			# Endpoints stay anchored to their junctions and the drawbridge.
			var sway: float = sin(t * PI) * (sin(t * TAU * 2.1 + float(i) * 1.37 + float(route_index)) * 21.0 + sin(t * TAU * 3.2 + float(route_index) * 0.9) * 9.0)
			var next: Vector2 = first.lerp(last, t) + normal * sway
			road_segments.append({"a": prev, "b": next, "min_x": minf(prev.x, next.x) - 78.0, "max_x": maxf(prev.x, next.x) + 78.0, "min_y": minf(prev.y, next.y) - 78.0, "max_y": maxf(prev.y, next.y) + 78.0})
			prev = next


func build_wilderness_roads() -> void:
	road_segments.clear()
	road_tile_lookup.clear()
	# Each Sanctuary drawbridge leads directly to one Forest road.
	var north_entry: Vector2 = north_zone_gate()
	var east_entry: Vector2 = east_zone_gate()
	var south_entry: Vector2 = south_zone_gate()
	var west_entry: Vector2 = west_zone_gate()
	append_winding_road([north_bridge_start(), TOWN + Vector2(90, -880), TOWN + Vector2(-120, -1680), TOWN + Vector2(180, -2460), north_entry], 1)
	append_winding_road([east_bridge_start(), TOWN + Vector2(980, 120), TOWN + Vector2(1730, -165), TOWN + Vector2(2540, 210), east_entry], 2)
	append_winding_road([south_bridge_start(), TOWN + Vector2(-110, 980), TOWN + Vector2(145, 1760), TOWN + Vector2(-180, 2530), south_entry], 3)
	append_winding_road([west_bridge_start(), TOWN + Vector2(-985, -130), TOWN + Vector2(-1780, 170), TOWN + Vector2(-2590, -205), west_entry], 4)
	# Continue each route deep into its destination biome.
	append_winding_road([north_entry, Vector2(TOWN.x + 320.0, FOREST_START - 980.0), Vector2(TOWN.x - 280.0, FOREST_START - 2320.0), Vector2(TOWN.x + 360.0, FOREST_START - 4050.0), Vector2(TOWN.x - 110.0, 32.0)], 11)
	append_winding_road([east_entry, Vector2(FOREST_END + 910.0, TOWN.y - 240.0), Vector2(FOREST_END + 2240.0, TOWN.y + 260.0), Vector2(FOREST_END + 4080.0, TOWN.y - 320.0), Vector2(WORLD_SIZE - 32.0, TOWN.y + 95.0)], 12)
	append_winding_road([south_entry, Vector2(TOWN.x - 310.0, FOREST_END + 1040.0), Vector2(TOWN.x + 290.0, FOREST_END + 2470.0), Vector2(TOWN.x - 350.0, FOREST_END + 4200.0), Vector2(TOWN.x + 90.0, WORLD_SIZE - 32.0)], 13)
	append_winding_road([west_entry, Vector2(FOREST_START - 980.0, TOWN.y + 210.0), Vector2(FOREST_START - 2380.0, TOWN.y - 320.0), Vector2(FOREST_START - 4190.0, TOWN.y + 290.0), Vector2(32.0, TOWN.y - 90.0)], 14)
	# Cache all road-bearing tiles once, rather than scanning every road segment during every draw or movement test.
	for seg in road_segments:
		var a: Vector2 = seg["a"]
		var b: Vector2 = seg["b"]
		var min_tile_x: int = int(floor(float(seg["min_x"]) / WORLD_TILE_SIZE))
		var max_tile_x: int = int(floor(float(seg["max_x"]) / WORLD_TILE_SIZE))
		var min_tile_y: int = int(floor(float(seg["min_y"]) / WORLD_TILE_SIZE))
		var max_tile_y: int = int(floor(float(seg["max_y"]) / WORLD_TILE_SIZE))
		var v: Vector2 = b - a
		var v_length_sq: float = maxf(v.length_squared(), 0.001)
		for tile_x in range(min_tile_x, max_tile_x + 1):
			for tile_y in range(min_tile_y, max_tile_y + 1):
				var center_point := Vector2((float(tile_x) + 0.5) * WORLD_TILE_SIZE, (float(tile_y) + 0.5) * WORLD_TILE_SIZE)
				var half_width: float = 57.0 + 5.0 * sin(center_point.x * 0.014 + center_point.y * 0.009)
				var fraction: float = clampf((center_point - a).dot(v) / v_length_sq, 0.0, 1.0)
				if center_point.distance_squared_to(a + v * fraction) <= half_width * half_width:
					road_tile_lookup[Vector2i(tile_x, tile_y)] = true

func is_on_wilderness_road(pos: Vector2) -> bool:
	if is_in_sanctuary(pos):
		return false
	var tile_coordinate: Vector2i = Vector2i(int(floor(pos.x / WORLD_TILE_SIZE)), int(floor(pos.y / WORLD_TILE_SIZE)))
	return road_tile_lookup.has(tile_coordinate)

func can_cross_zone_boundary(previous: Vector2, desired: Vector2) -> bool:
	var from_zone: int = zone_id_at(previous)
	var to_zone: int = zone_id_at(desired)
	if from_zone < 0 or to_zone < 0:
		return false
	if from_zone == to_zone:
		return true
	# Crossings between Forest and adjacent regions only have one legal opening.
	# The opening is centered on the corresponding road, with solid boundary
	# collisions everywhere else. The current world is a cross of five zones.
	if from_zone != 0 and to_zone != 0:
		return false
	if (from_zone == 1 or to_zone == 1) or (from_zone == 3 or to_zone == 3):
		return absf(desired.y - TOWN.y) <= ZONE_GATE_HALF_WIDTH
	if (from_zone == 2 or to_zone == 2) or (from_zone == 4 or to_zone == 4):
		return absf(desired.x - TOWN.x) <= ZONE_GATE_HALF_WIDTH
	return false

func move_player_through_gate(previous: Vector2, desired: Vector2) -> Vector2:
	# Axis-wise wall collision prevents skipping through a wall at low FPS.
	var min_x := TOWN.x - CASTLE_HALF.x
	var max_x := TOWN.x + CASTLE_HALF.x
	var min_y := TOWN.y - CASTLE_HALF.y
	var max_y := TOWN.y + CASTLE_HALF.y
	var p := previous
	var x_target: float = desired.x
	if p.y > min_y - PLAYER_WALL_PADDING and p.y < max_y + PLAYER_WALL_PADDING:
		if p.x < min_x and x_target >= min_x - PLAYER_WALL_PADDING and not is_on_horizontal_gate_lane(p):
			x_target = min_x - PLAYER_WALL_PADDING
		elif p.x > max_x and x_target <= max_x + PLAYER_WALL_PADDING and not is_on_horizontal_gate_lane(p):
			x_target = max_x + PLAYER_WALL_PADDING
		elif p.x >= min_x and p.x <= max_x:
			if x_target < min_x + PLAYER_WALL_PADDING and not is_on_horizontal_gate_lane(p):
				x_target = min_x + PLAYER_WALL_PADDING
			elif x_target > max_x - PLAYER_WALL_PADDING and not is_on_horizontal_gate_lane(p):
				x_target = max_x - PLAYER_WALL_PADDING
	p.x = x_target
	var y_target: float = desired.y
	if p.x > min_x - PLAYER_WALL_PADDING and p.x < max_x + PLAYER_WALL_PADDING:
		if p.y < min_y and y_target >= min_y - PLAYER_WALL_PADDING and not is_on_vertical_gate_lane(p):
			y_target = min_y - PLAYER_WALL_PADDING
		elif p.y > max_y and y_target <= max_y + PLAYER_WALL_PADDING and not is_on_vertical_gate_lane(p):
			y_target = max_y + PLAYER_WALL_PADDING
		elif p.y >= min_y and p.y <= max_y:
			if y_target < min_y + PLAYER_WALL_PADDING and not is_on_vertical_gate_lane(p):
				y_target = min_y + PLAYER_WALL_PADDING
			elif y_target > max_y - PLAYER_WALL_PADDING and not is_on_vertical_gate_lane(p):
				y_target = max_y - PLAYER_WALL_PADDING
	p.y = y_target
	return p

func keep_enemy_outside_castle(pos: Vector2, old_pos: Vector2) -> Vector2:
	# Enemies never use the player-only drawbridge. Keep them outside all sides.
	var outside_rect := castle_rect().grow(ENEMY_CLEARANCE)
	if not outside_rect.has_point(pos):
		return pos
	var min_x := outside_rect.position.x
	var max_x := outside_rect.end.x
	var min_y := outside_rect.position.y
	var max_y := outside_rect.end.y
	if old_pos.x <= min_x:
		pos.x = min_x - 1.0
	elif old_pos.x >= max_x:
		pos.x = max_x + 1.0
	elif old_pos.y <= min_y:
		pos.y = min_y - 1.0
	elif old_pos.y >= max_y:
		pos.y = max_y + 1.0
	else:
		# Recovery for enemies that may have been inside an older save/state.
		var d_left := pos.x - min_x
		var d_right := max_x - pos.x
		var d_top := pos.y - min_y
		var d_bottom := max_y - pos.y
		var nearest := minf(minf(d_left, d_right), minf(d_top, d_bottom))
		if nearest == d_left:
			pos.x = min_x - 1.0
		elif nearest == d_right:
			pos.x = max_x + 1.0
		elif nearest == d_top:
			pos.y = min_y - 1.0
		else:
			pos.y = max_y + 1.0
	return pos

func bolt_crosses_sanctuary(start: Vector2, finish: Vector2) -> bool:
	# Rect2 does not provide intersects_segment() in Godot 4.
	# First check whether either endpoint is inside the safe zone.
	if is_in_sanctuary(start) or is_in_sanctuary(finish):
		return true
	# Check the moving bolt against the four rectangle edges.
	var rect: Rect2 = castle_rect()
	var top_left: Vector2 = rect.position
	var top_right: Vector2 = Vector2(rect.end.x, rect.position.y)
	var bottom_right: Vector2 = rect.end
	var bottom_left: Vector2 = Vector2(rect.position.x, rect.end.y)
	return (
		Geometry2D.segment_intersects_segment(start, finish, top_left, top_right) != null
		or Geometry2D.segment_intersects_segment(start, finish, top_right, bottom_right) != null
		or Geometry2D.segment_intersects_segment(start, finish, bottom_right, bottom_left) != null
		or Geometry2D.segment_intersects_segment(start, finish, bottom_left, top_left) != null
	)

func roll_critical_hit() -> bool:
	# One independent roll per successful player hit, including projectiles.
	return world_rng.randf() < player_crit_chance()

func critical_damage(base_damage: float, is_critical: bool) -> float:
	return base_damage * (CRIT_DAMAGE_MULTIPLIER if is_critical else 1.0)

func show_combat_number(world_pos: Vector2, amount: float, healing: bool = false, is_critical: bool = false) -> void:
	var number: int = int(round(amount))
	if number <= 0:
		return
	# Tiny deterministic spread avoids overlapping simultaneous hits.
	var offset: float = float(combat_texts.size() % 4) * 8.0 - 12.0
	combat_texts.append({"pos": world_pos + Vector2(offset, -25.0),
		"number": number, "healing": healing, "critical": is_critical,
		"time": 1.15 if is_critical else 0.90, "duration": 1.15 if is_critical else 0.90})
	if combat_texts.size() > 45:
		combat_texts.pop_front()

func update_combat_numbers(delta: float) -> void:
	for i in range(combat_texts.size() - 1, -1, -1):
		var popup: Dictionary = combat_texts[i]
		popup["time"] = float(popup["time"]) - delta
		popup["pos"] = Vector2(popup["pos"]) + Vector2(0.0, -40.0 * delta)
		if float(popup["time"]) <= 0.0:
			combat_texts.remove_at(i)
		else:
			combat_texts[i] = popup

func stat_amount(key: String) -> int:
	if active_slot < 0:
		return 0
	var stats: Dictionary = slots[active_slot]["stats"]
	return maxi(0, int(stats.get(key, 0)))

func character_max_hp() -> float:
	return (150.0 if active_slot == 0 else 100.0) + float(stat_amount("Hitpoints")) * 3.0 + float(get_equipment_bonus("hp"))

func melee_stat_bonus() -> float:
	return float(stat_amount("Strength")) * 2.0

func ranged_stat_bonus() -> float:
	return float(stat_amount("Dexterity")) * 2.0

func magic_stat_bonus() -> float:
	return float(stat_amount("Intellect")) * 2.0

func movement_stat_multiplier() -> float:
	return 1.0 + float(stat_amount("Speed")) * 0.002

func item_drop_bonus() -> float:
	# Each luck point adds 0.2 percentage points to independent item drops.
	return float(stat_amount("Luck")) * 0.002

func knight_has_shield() -> bool:
	if active_slot != 0:
		return false
	var offhand_id: String = str(slots[active_slot]["equipment"].get("offhand", ""))
	return offhand_id != "" and item_base_id(offhand_id).ends_with("shield")

func knight_has_two_handed() -> bool:
	if active_slot != 0:
		return false
	return is_two_handed_weapon(str(slots[active_slot]["equipment"].get("weapon", "")))

func knight_ability_mode() -> String:
	if knight_has_two_handed():
		return "bladestorm"
	if knight_has_shield():
		return "aegis"
	return "none"

func knight_ability_is_ready() -> bool:
	if active_slot != 0 or knight_ability_timer > 0.0 or bladestorm_timer > 0.0:
		return false
	if knight_ability_mode() == "aegis":
		return knight_ability_charge >= KNIGHT_ABILITY_REQUIRED
	if knight_ability_mode() == "bladestorm":
		return bladestorm_charge >= KNIGHT_ABILITY_REQUIRED
	return false

func add_knight_ability_charge(amount: int = 1) -> void:
	if active_slot != 0 or amount <= 0:
		return
	# Keep two independent counters. Swapping equipment does not charge
	# the ability that is currently unavailable.
	var mode: String = knight_ability_mode()
	if mode == "aegis" and knight_ability_charge < KNIGHT_ABILITY_REQUIRED:
		knight_ability_charge = mini(KNIGHT_ABILITY_REQUIRED, knight_ability_charge + amount)
		if knight_ability_charge >= KNIGHT_ABILITY_REQUIRED:
			status_message = "Aegis Protection ready!"
			status_timer = maxf(status_timer, 2.0)
	elif mode == "bladestorm" and bladestorm_charge < KNIGHT_ABILITY_REQUIRED:
		bladestorm_charge = mini(KNIGHT_ABILITY_REQUIRED, bladestorm_charge + amount)
		if bladestorm_charge >= KNIGHT_ABILITY_REQUIRED:
			status_message = "Bladestorm ready!"
			status_timer = maxf(status_timer, 2.0)

func knight_two_handed_damage() -> float:
	var two_hand_id: String = str(slots[active_slot]["equipment"].get("weapon", ""))
	var damage: float = 26.0 + melee_stat_bonus() + float(get_equipment_bonus("atk"))
	if is_two_handed_weapon(two_hand_id):
		var one_hand_id: String = "iron_sword_t2" if two_hand_id.ends_with("_t2") else "iron_sword"
		var extra_weapon_atk: float = float(ITEM_DATA[two_hand_id]["atk"]) - float(ITEM_DATA[one_hand_id]["atk"])
		damage = (damage - extra_weapon_atk) * 1.30
	return damage

func bladestorm_damage_pulse() -> void:
	if not knight_has_two_handed() or dead_timer > 0.0:
		return
	var base_damage: float = knight_two_handed_damage()
	# Hit all living enemies within the rotating three-sword ring once per second.
	for i in range(enemies.size() - 1, -1, -1):
		var enemy: Dictionary = enemies[i]
		if float(enemy.get("hp", 0.0)) <= 0.0:
			continue
		var boss_target: bool = int(enemy["type"]) == 2
		var hit_pos: Vector2 = morvex_nearest_hit_point(player) if boss_target else Vector2(enemy["pos"])
		if player.distance_squared_to(hit_pos) > KNIGHT_ABILITY_RADIUS * KNIGHT_ABILITY_RADIUS:
			continue
		var before: float = float(enemy["hp"])
		var is_critical: bool = roll_critical_hit()
		enemy["hp"] = maxf(0.0, before - critical_damage(base_damage, is_critical))
		var dealt: float = before - float(enemy["hp"])
		if dealt > 0.0:
			show_combat_number(hit_pos, dealt, false, is_critical)
			enemy["hit_flash"] = 0.18
			enemies[i] = enemy
			if float(enemy["hp"]) <= 0.0:
				defeat_enemy(i)

func activate_knight_ability() -> void:
	if active_slot != 0 or inventory_open or shop_open or bank_open or oracle_open or stat_window_open:
		return
	if knight_ability_timer > 0.0 or bladestorm_timer > 0.0:
		status_message = "Knight ability already active"
		status_timer = 1.2
		return
	var mode: String = knight_ability_mode()
	if mode == "none":
		status_message = "Equip a shield for Aegis or a two-handed sword for Bladestorm"
		status_timer = 2.0
		return
	var charge: int = bladestorm_charge if mode == "bladestorm" else knight_ability_charge
	if charge < KNIGHT_ABILITY_REQUIRED:
		status_message = "%s charge %d / %d" % ["Bladestorm" if mode == "bladestorm" else "Aegis Protection", charge, KNIGHT_ABILITY_REQUIRED]
		status_timer = 1.2
		return
	if mode == "bladestorm":
		bladestorm_charge = 0
		bladestorm_timer = BLADESTORM_DURATION
		bladestorm_tick_timer = BLADESTORM_TICK
		bladestorm_spin = 0.0
		status_message = "Bladestorm! Three swords for 7 seconds"
	else:
		knight_ability_charge = 0
		knight_ability_timer = KNIGHT_ABILITY_DURATION
		knight_ability_spin = 0.0
		status_message = "Aegis Protection! Shield barrier active"
	status_timer = 2.0
	queue_redraw()

func toggle_stats_window() -> void:
	if active_slot < 0:
		return
	stat_window_open = not stat_window_open
	left_touch = -1
	right_touch = -1
	pointer_held = false
	mobile_fire = false
	fire_stick_mode = false
	queue_redraw()

func allocate_stat_point(stat_name: String) -> void:
	if not STAT_KEYS.has(stat_name) or active_slot < 0:
		return
	if int(slots[active_slot]["stat_points"]) <= 0:
		return
	slots[active_slot]["stat_points"] = int(slots[active_slot]["stat_points"]) - 1
	var stats: Dictionary = slots[active_slot]["stats"]
	stats[stat_name] = int(stats[stat_name]) + 1
	var level_stats: Dictionary = slots[active_slot]["level_stats"]
	level_stats[stat_name] = int(level_stats.get(stat_name, 0)) + 1
	if stat_name == "Hitpoints":
		max_hp = character_max_hp()
		hp = minf(max_hp, hp + 3.0)
		show_combat_number(player, 3.0, true)
	save_slots()
	queue_redraw()

func handle_stat_tap(point: Vector2) -> void:
	if STAT_CLOSE_BUTTON.has_point(point):
		toggle_stats_window()
		return
	for i in range(STAT_KEYS.size()):
		var plus_rect := Rect2(STAT_PLUS_X - 6.0, STAT_ROW_START + float(i) * STAT_ROW_GAP - 29.0, 68.0, 47.0)
		if plus_rect.has_point(point):
			allocate_stat_point(str(STAT_KEYS[i]))
			return

func draw_stats_window() -> void:
	draw_rect(Rect2(65, 63, 830, 430), Color("111b2c"))
	draw_rect(Rect2(65, 63, 830, 430), Color("d8ba7d"), false, 3.0)
	draw_label("CHARACTER ATTRIBUTES", Vector2(108, 106), 25, Color("f5d99d"))
	draw_label("Unspent points: %d" % int(slots[active_slot]["stat_points"]), Vector2(113, 142), 19, Color("c2f2d2"))
	draw_rect(STAT_CLOSE_BUTTON, Color("914d4a"))
	draw_label("X", Vector2(837, 117), 24)
	var descriptions := ["+2 melee damage", "+2 physical ranged damage", "+2 magic damage", "+3 maximum HP", "+0.2% move speed", "+0.2% item drop chance"]
	for i in range(STAT_KEYS.size()):
		var ypos: float = STAT_ROW_START + float(i) * STAT_ROW_GAP
		var key: String = str(STAT_KEYS[i])
		draw_rect(Rect2(102, ypos - 32.0, 721, 47), Color("243249"))
		draw_label(key, Vector2(120, ypos - 1.0), 20, Color("f5e6ce"))
		draw_label("%d" % stat_amount(key), Vector2(332, ypos - 1.0), 20, Color("ffffff"))
		draw_label(str(descriptions[i]), Vector2(406, ypos - 1.0), 17, Color("a9c9e3"))
		var plus_rect := Rect2(STAT_PLUS_X - 6.0, ypos - 29.0, 68.0, 47.0)
		draw_rect(plus_rect, Color("407957") if int(slots[active_slot]["stat_points"]) > 0 else Color("4a5360"))
		draw_rect(plus_rect, Color("b3e4bd"), false, 2.0)
		draw_label("+", plus_rect.position + Vector2(25, 33), 28)
	if int(slots[active_slot]["level"]) >= LEVEL_CAP:
		draw_label("LEVEL 100 - MAX LEVEL", Vector2(115, 469), 16, Color("d7ddeb"))
	else:
		draw_label("Lv %d / %d   |   XP %d / %d" % [int(slots[active_slot]["level"]), LEVEL_CAP, int(slots[active_slot]["xp"]), xp_needed(int(slots[active_slot]["level"]))], Vector2(115, 469), 16, Color("d7ddeb"))

# Tile-based cave layout; corridors create a winding maze before the boss arena.
func dungeon_carve_cell(cell_x: int, cell_y: int, radius: int = 0) -> void:
	for x in range(cell_x - radius, cell_x + radius + 1):
		for y in range(cell_y - radius, cell_y + radius + 1):
			if x > 0 and x < DUNGEON_COLS - 1 and y > 0 and y < DUNGEON_ROWS - 1:
				dungeon_walkable[Vector2i(x, y)] = true

func dungeon_carve_path(cells: Array, radius: int = 1) -> void:
	for i in range(cells.size() - 1):
		var start: Vector2i = Vector2i(cells[i])
		var finish: Vector2i = Vector2i(cells[i + 1])
		var x: int = start.x
		var y: int = start.y
		dungeon_carve_cell(x, y, radius)
		while x != finish.x:
			x += 1 if finish.x > x else -1
			dungeon_carve_cell(x, y, radius)
		while y != finish.y:
			y += 1 if finish.y > y else -1
			dungeon_carve_cell(x, y, radius)

func build_dungeon_layout() -> void:
	dungeon_walkable.clear()
	dungeon_carve_path([Vector2i(2, 26), Vector2i(2, 23), Vector2i(8, 23), Vector2i(8, 19), Vector2i(4, 19), Vector2i(4, 14), Vector2i(13, 14), Vector2i(13, 10), Vector2i(8, 10), Vector2i(8, 6), Vector2i(17, 6), Vector2i(17, 11), Vector2i(23, 11), Vector2i(23, 5), Vector2i(27, 5)], 1)
	# Side passages and false turns make it a maze, not just a straight tunnel.
	dungeon_carve_path([Vector2i(8, 20), Vector2i(14, 20), Vector2i(14, 24), Vector2i(18, 24)], 0)
	dungeon_carve_path([Vector2i(4, 16), Vector2i(2, 16), Vector2i(2, 11), Vector2i(5, 11)], 0)
	dungeon_carve_path([Vector2i(13, 12), Vector2i(18, 12), Vector2i(18, 16), Vector2i(21, 16)], 0)
	dungeon_carve_path([Vector2i(8, 7), Vector2i(4, 7), Vector2i(4, 3), Vector2i(10, 3)], 0)
	dungeon_carve_path([Vector2i(18, 7), Vector2i(20, 7), Vector2i(20, 3), Vector2i(23, 3)], 0)
	# Wide, open final chamber reserved for the giant bat boss.
	for x in range(25, 35):
		for y in range(2, 11):
			dungeon_carve_cell(x, y)

func dungeon_floor_at(pos: Vector2) -> bool:
	var cx: int = int(floor(pos.x / DUNGEON_TILE))
	var cy: int = int(floor(pos.y / DUNGEON_TILE))
	return dungeon_walkable.has(Vector2i(cx, cy))

func dungeon_can_walk(pos: Vector2) -> bool:
	var margin: float = 12.0
	return dungeon_floor_at(pos + Vector2(margin, 0)) and dungeon_floor_at(pos + Vector2(-margin, 0)) and dungeon_floor_at(pos + Vector2(0, margin)) and dungeon_floor_at(pos + Vector2(0, -margin))

func populate_bat_cave() -> void:
	# This is a fresh dungeon instance: the bats and boss have dungeon-local positions.
	# Fixed spawns are placed on walkable tunnel cells so none spawn inside rock.
	var bat_cells: Array = [
		Vector2i(3, 23), Vector2i(6, 23), Vector2i(8, 21),
		Vector2i(5, 19), Vector2i(4, 16), Vector2i(9, 14),
		Vector2i(13, 12), Vector2i(10, 10), Vector2i(8, 8),
		Vector2i(14, 6), Vector2i(17, 9), Vector2i(20, 11),
		Vector2i(23, 8), Vector2i(25, 5)
	]
	for cell in bat_cells:
		var point: Vector2 = (Vector2(cell) + Vector2(0.5, 0.5)) * DUNGEON_TILE
		if not dungeon_can_walk(point):
			continue
		enemies.append({"pos": point, "hp": CAVE_BAT_HP, "max_hp": CAVE_BAT_HP,
			"speed": 94.0, "damage": CAVE_BAT_DAMAGE,
			"type": 1, "level": CAVE_BAT_LEVEL, "dungeon": true,
			"hit_cd": 0.0, "hit_flash": 0.0,
			"shoot_cd": world_rng.randf_range(0.4, 1.5), "facing": Vector2.DOWN})
	# Boss has its own large hitbox and is not allowed to leave its final chamber.
	enemies.append({"pos": DUNGEON_BOSS_CENTER, "hp": MORVEX_HP, "max_hp": MORVEX_HP,
		"speed": 0.0, "damage": MORVEX_SONIC_DAMAGE,
		"type": 2, "level": MORVEX_LEVEL, "dungeon": true,
		"hit_cd": 0.0, "hit_flash": 0.0,
		"shoot_cd": 0.0, "facing": Vector2.DOWN})
	morvex_windup_timer = 0.0
	morvex_attack_cooldown = 0.65
	morvex_attack_telegraph = -1
	morvex_wave_pattern = 0
	morvex_attack_style = 0
	blood_bat_spawn_timer = 0.0
	morvex_defeated = false

func morvex_lane_count(style: int = -1) -> int:
	var active_style: int = morvex_attack_style if style < 0 else style
	return MORVEX_WAVE_LANES if active_style == 0 else MORVEX_ALT_WAVE_LANES

func is_morvex_wave_lane_gap(lane: int, pattern: int, style: int = -1) -> bool:
	# Pattern A: dense 16-lane ring with two 45-degree dodge lanes.
	# Pattern B: heavier 12-lane ring with two broader opposite dodge lanes.
	var active_style: int = morvex_attack_style if style < 0 else style
	if active_style == 0:
		var relative_lane: int = posmod(lane - pattern, 8)
		return relative_lane == 0 or relative_lane == 1
	var alt_relative: int = posmod(lane - pattern, 6)
	return alt_relative == 0 or alt_relative == 1

func fire_morvex_sonic_volley() -> void:
	var lane_count: int = morvex_lane_count()
	var angle_offset: float = 0.0 if morvex_attack_style == 0 else PI / float(lane_count)
	# Launch from Morvex's core rather than outside his torso.
	var inner_offset: float = 0.0
	var wave_life: float = 3.0 if morvex_attack_style == 0 else 3.4
	for lane in range(lane_count):
		if is_morvex_wave_lane_gap(lane, morvex_attack_telegraph, morvex_attack_style):
			continue
		var angle: float = angle_offset + TAU * float(lane) / float(lane_count)
		var direction: Vector2 = Vector2.RIGHT.rotated(angle)
		enemy_projectiles.append({"pos": DUNGEON_BOSS_CENTER + direction * inner_offset,
			"velocity": direction * MORVEX_WAVE_SPEED, "life": wave_life,
			"damage": MORVEX_SONIC_DAMAGE, "sonic": true, "thick": morvex_attack_style == 1})
	# Remaining inside the boss is never a safe spot: his chest is the source.
	if player.distance_to(DUNGEON_BOSS_CENTER) <= 78.0:
		apply_enemy_damage(MORVEX_SONIC_DAMAGE)
	if morvex_attack_style == 0:
		morvex_wave_pattern = (morvex_wave_pattern + 2) % 8
	else:
		morvex_wave_pattern = (morvex_wave_pattern + 1) % 6
	morvex_attack_telegraph = -1
	morvex_attack_style = 1 - morvex_attack_style

func count_blood_bats_in_boss_chamber() -> int:
	var count: int = 0
	for enemy in enemies:
		if int(enemy["type"]) != 1 or not bool(enemy.get("dungeon", false)):
			continue
		if Vector2(enemy["pos"]).distance_squared_to(DUNGEON_BOSS_CENTER) <= BLOOD_BAT_CHAMBER_RADIUS * BLOOD_BAT_CHAMBER_RADIUS:
			count += 1
	return count

func summon_morvex_blood_bats() -> void:
	var remaining: int = BLOOD_BAT_BOSS_CAP - count_blood_bats_in_boss_chamber()
	if remaining <= 0:
		return
	# Spawn at the edges of the chamber rather than directly on the player.
	# Fixed candidate positions are inside the carved arena (validated below).
	var offsets: Array = [
		Vector2(-192.0, -128.0), Vector2(192.0, 128.0),
		Vector2(192.0, -128.0), Vector2(-192.0, 128.0),
		Vector2(-230.0, 0.0), Vector2(230.0, 0.0),
		Vector2(0.0, 160.0), Vector2(0.0, -160.0),
		Vector2(-125.0, 160.0), Vector2(125.0, -160.0)
	]
	var spawned: int = 0
	var first: int = world_rng.randi_range(0, offsets.size() - 1)
	for i in range(offsets.size()):
		if spawned >= mini(BLOOD_BAT_SUMMON_COUNT, remaining):
			break
		var spawn_pos: Vector2 = DUNGEON_BOSS_CENTER + Vector2(offsets[(first + i) % offsets.size()])
		if not dungeon_can_walk(spawn_pos) or player.distance_squared_to(spawn_pos) < 125.0 * 125.0:
			continue
		var occupied: bool = false
		for other in enemies:
			if int(other["type"]) == 1 and Vector2(other["pos"]).distance_squared_to(spawn_pos) < 64.0 * 64.0:
				occupied = true
				break
		if occupied:
			continue
		enemies.append({"pos": spawn_pos, "hp": CAVE_BAT_HP, "max_hp": CAVE_BAT_HP,
			"speed": 94.0, "damage": CAVE_BAT_DAMAGE, "type": 1,
			"level": CAVE_BAT_LEVEL, "dungeon": true, "summoned": true,
			"hit_cd": 0.0, "hit_flash": 0.0,
			"shoot_cd": world_rng.randf_range(0.6, 1.4), "facing": Vector2.DOWN})
		spawned += 1

func update_morvex(delta: float) -> void:
	var boss_present: bool = false
	for enemy in enemies:
		if int(enemy["type"]) == 2:
			boss_present = true
			break
	if not boss_present:
		morvex_windup_timer = 0.0
		morvex_attack_telegraph = -1
		blood_bat_spawn_timer = 0.0
		return
	if player.distance_to(DUNGEON_BOSS_CENTER) > 675.0:
		return
	# Summon two Blood Bats every four seconds while Morvex is alive.
	blood_bat_spawn_timer += delta
	if blood_bat_spawn_timer >= BLOOD_BAT_SUMMON_INTERVAL:
		blood_bat_spawn_timer -= BLOOD_BAT_SUMMON_INTERVAL
		summon_morvex_blood_bats()
	if morvex_windup_timer > 0.0:
		morvex_windup_timer -= delta
		if morvex_windup_timer <= 0.0:
			fire_morvex_sonic_volley()
			morvex_attack_cooldown = MORVEX_WAVE_INTERVAL
		return
	morvex_attack_cooldown = maxf(0.0, morvex_attack_cooldown - delta)
	if morvex_attack_cooldown <= 0.0:
		morvex_attack_telegraph = morvex_wave_pattern
		morvex_windup_timer = MORVEX_WINDUP
		status_message = "MORVEX: %s - find a gap!" % ("Crimson Pulse" if morvex_attack_style == 0 else "Blood Spiral")
		status_timer = 1.0

func enter_forest_dungeon() -> void:
	if dungeon_active or cave_portal_cooldown > 0.0:
		return
	portal_cast_timer = 0.0
	clear_sanctuary_portal()
	dungeon_active = true
	player = DUNGEON_ENTRY
	footprint_last_pos = player
	footprint_distance_walked = 0.0
	cosmetic_footprints.clear()
	cave_portal_cooldown = 1.4
	projectiles.clear()
	enemy_projectiles.clear()
	enemies.clear()
	drops.clear()
	combat_texts.clear()
	populate_bat_cave()
	status_message = "Bat Cave - follow the tunnels to Morvex"
	status_timer = 3.2
	invulnerable = maxf(invulnerable, 0.9)

func leave_forest_dungeon() -> void:
	if not dungeon_active or cave_portal_cooldown > 0.0:
		return
	portal_cast_timer = 0.0
	clear_sanctuary_portal()
	dungeon_active = false
	player = FOREST_CAVE_POS + Vector2(0, 100)
	footprint_last_pos = player
	footprint_distance_walked = 0.0
	cosmetic_footprints.clear()
	cave_portal_cooldown = 1.4
	current_zone_id = 0
	projectiles.clear()
	enemy_projectiles.clear()
	enemies.clear()
	drops.clear()
	morvex_windup_timer = 0.0
	morvex_attack_telegraph = -1
	status_message = "Returned to The Forest"
	status_timer = 2.0
	invulnerable = maxf(invulnerable, 0.9)

func update_dungeon_player(delta: float) -> void:
	var previous_pos: Vector2 = player
	var move_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if left_touch != -1:
		move_dir = (joystick_current - joystick_origin).limit_length(65.0) / 65.0
	if move_dir.length_squared() > 1.0:
		move_dir = move_dir.normalized()
	var speed: float = (205.0 if active_slot != 4 else 255.0) * movement_stat_multiplier()
	var requested: Vector2 = player + move_dir * speed * delta
	# Separating axes lets the player slide along solid cave walls.
	var horizontal: Vector2 = Vector2(requested.x, player.y)
	if dungeon_can_walk(horizontal):
		player = horizontal
	var vertical: Vector2 = Vector2(player.x, requested.y)
	if dungeon_can_walk(vertical):
		player = vertical
	if mobile_fire and fire_stick_mode:
		var stick_direction: Vector2 = fire_stick_position - fire_stick_origin
		if stick_direction.length_squared() >= AIM_DEADZONE * AIM_DEADZONE:
			facing_direction = stick_direction.normalized()
	elif pointer_held or mobile_fire:
		var look_dir: Vector2 = aim_point - VIEW * 0.5
		if look_dir.length_squared() > 16.0:
			facing_direction = look_dir.normalized()
	elif move_dir.length_squared() > 0.01:
		facing_direction = move_dir.normalized()
	update_bloody_footsteps(previous_pos)
	if cave_portal_cooldown <= 0.0 and player.distance_to(DUNGEON_EXIT) <= CAVE_PORTAL_RADIUS:
		leave_forest_dungeon()

func start_portal_cast() -> void:
	if active_slot < 0 or dead_timer > 0.0:
		return
	if portal_cast_timer > 0.0:
		status_message = "Portal already channeling"
		status_timer = 1.0
		return
	portal_origin = player
	portal_cast_in_dungeon = dungeon_active
	portal_cast_timer = PORTAL_CAST_TIME
	status_message = "Portal opens at this location in 3 seconds"
	status_timer = 1.7
	queue_redraw()

func clear_sanctuary_portal() -> void:
	sanctuary_portal_time = 0.0
	sanctuary_portal_requires_exit = false

func use_sanctuary_portal() -> void:
	clear_sanctuary_portal()
	portal_cast_timer = 0.0
	if dungeon_active:
		enemies.clear()
		projectiles.clear()
		enemy_projectiles.clear()
		drops.clear()
	dungeon_active = false
	current_zone_id = 0
	player = FOUNTAIN_POS
	footprint_last_pos = player
	footprint_distance_walked = 0.0
	cosmetic_footprints.clear()
	facing_direction = Vector2.UP
	status_message = "Returned to the Sanctuary fountain"
	status_timer = 2.2
	invulnerable = maxf(invulnerable, 0.6)

func update_sanctuary_portal(delta: float) -> void:
	if sanctuary_portal_time <= 0.0:
		return
	sanctuary_portal_time = maxf(0.0, sanctuary_portal_time - delta)
	if sanctuary_portal_time <= 0.0:
		clear_sanctuary_portal()
		return
	if dungeon_active != sanctuary_portal_in_dungeon:
		clear_sanctuary_portal()
		return
	var portal_distance: float = player.distance_to(sanctuary_portal_pos)
	if sanctuary_portal_requires_exit:
		if portal_distance > SANCTUARY_PORTAL_RADIUS + 18.0:
			sanctuary_portal_requires_exit = false
	elif portal_distance <= SANCTUARY_PORTAL_RADIUS and dead_timer <= 0.0:
		use_sanctuary_portal()

func draw_sanctuary_return_portal(camera: Vector2) -> void:
	if sanctuary_portal_time <= 0.0 or sanctuary_portal_in_dungeon != dungeon_active:
		return
	var c: Vector2 = sanctuary_portal_pos - camera
	var pulse: float = 0.75 + 0.25 * sin(lightning_clock * 6.0)
	draw_circle(c + Vector2(0, 14), 36.0, Color(0.25, 0.75, 1.0, 0.16))
	draw_circle(c, 33.0, Color(0.09, 0.22, 0.39, 0.75))
	draw_arc(c, 32.0, 0.0, TAU, 52, Color(0.37, 0.86, 1.0, pulse), 6.0)
	draw_arc(c, 22.0, lightning_clock * 2.0, lightning_clock * 2.0 + TAU * 0.90, 42, Color("d1a1ff"), 5.0)
	draw_circle(c, 13.0, Color(0.65, 0.94, 1.0, 0.55 * pulse))
	draw_label("SANCTUARY", c + Vector2(-51, -51), 15, Color("cfeeff"))
	draw_label("%ds" % int(ceil(sanctuary_portal_time)), c + Vector2(-9, 57), 14, Color("dff4ff"))


func draw_bloody_footprints(camera: Vector2) -> void:
	# World-space footprints are painted over the terrain but under the player.
	# Each mark has a true boot sole + heel + toes and fades over two seconds.
	for mark in cosmetic_footprints:
		var opacity: float = clampf(float(mark.get("life", 0.0)) / BLOODY_FOOTPRINT_LIFETIME, 0.0, 1.0)
		if opacity <= 0.0:
			continue
		var c: Vector2 = Vector2(mark["pos"]) - camera
		if c.x < -30.0 or c.x > VIEW.x + 30.0 or c.y < -30.0 or c.y > VIEW.y + 30.0:
			continue
		var angle: float = float(mark.get("angle", 0.0))
		draw_set_transform(c, angle, Vector2.ONE)
		var dark: Color = Color(0.43, 0.015, 0.035, opacity * 0.35)
		var red: Color = Color(0.86, 0.065, 0.075, opacity * 0.32)
		var highlight: Color = Color(1.0, 0.23, 0.19, opacity * 0.22)
		# Orientation follows the movement direction, including diagonal movement.
		draw_circle(Vector2(0, 6), 6.7, dark)
		draw_circle(Vector2(0, 5), 4.8, red)
		draw_colored_polygon(PackedVector2Array([
			Vector2(-7, 1), Vector2(-8, -6), Vector2(-6, -12),
			Vector2(6, -12), Vector2(8, -6), Vector2(7, 1)
		]), dark)
		draw_colored_polygon(PackedVector2Array([
			Vector2(-5, 0), Vector2(-6, -6), Vector2(-4, -10),
			Vector2(4, -10), Vector2(6, -6), Vector2(5, 0)
		]), red)
		draw_line(Vector2(-4, -7), Vector2(1, -8), highlight, 1.7)
		for toe in range(4):
			var xx: float = -5.5 + float(toe) * 3.4
			draw_circle(Vector2(xx, -14.0 - (1.5 if toe == 1 or toe == 2 else 0.0)), 2.2, red)
		# Irregular crimson smudges make the footsteps distinct on grass and stone.
		draw_circle(Vector2(7, 4), 2.8, Color(0.65, 0.04, 0.07, opacity * 0.23))
		draw_circle(Vector2(-8, -1), 1.8, Color(0.70, 0.025, 0.05, opacity * 0.23))
		draw_set_transform(Vector2.ZERO)

func update_cosmetic_footprints(delta: float) -> void:
	for i in range(cosmetic_footprints.size() - 1, -1, -1):
		cosmetic_footprints[i]["life"] = float(cosmetic_footprints[i]["life"]) - delta
		if float(cosmetic_footprints[i]["life"]) <= 0.0:
			cosmetic_footprints.remove_at(i)

func spawn_bloody_footprint(step_pos: Vector2, move_dir: Vector2, left_step: bool) -> void:
	var direction: Vector2 = move_dir.normalized()
	if direction.length_squared() < 0.01:
		return
	var sideways: Vector2 = Vector2(-direction.y, direction.x)
	# Put alternating feet just behind the moving character, not underneath it.
	var offset: Vector2 = sideways * (-8.0 if left_step else 8.0) - direction * 7.0
	cosmetic_footprints.append({
		"pos": step_pos + offset,
		"life": BLOODY_FOOTPRINT_LIFETIME,
		"angle": direction.angle() + PI * 0.5
	})
	# Hard cap prevents runaway draw cost on lower-end phones.
	if cosmetic_footprints.size() > 36:
		cosmetic_footprints.pop_front()

func update_bloody_footsteps(previous_pos: Vector2) -> void:
	if active_slot < 0:
		return
	var cosmetic_id: String = str(slots[active_slot]["equipment"].get("cosmetic", ""))
	if cosmetic_id != "bloody_footprints":
		footprint_distance_walked = 0.0
		footprint_last_pos = player
		return
	var movement: Vector2 = player - previous_pos
	var travel: float = movement.length()
	if travel < 0.001:
		return
	# Distance-walked accumulator works reliably through sharp turns, unlike
	# measuring distance from a prior spawn anchor.
	var direction: Vector2 = movement / travel
	var remaining: float = travel
	var cursor: Vector2 = previous_pos
	while footprint_distance_walked + remaining >= BLOODY_FOOTSTEP_DISTANCE:
		var distance_needed: float = BLOODY_FOOTSTEP_DISTANCE - footprint_distance_walked
		cursor += direction * distance_needed
		spawn_bloody_footprint(cursor, direction, footprint_left_step)
		footprint_left_step = not footprint_left_step
		remaining -= distance_needed
		footprint_distance_walked = 0.0
	footprint_distance_walked += remaining
	footprint_last_pos = player

func _process(delta: float) -> void:
	if active_slot < 0:
		return
	cave_portal_cooldown = maxf(0.0, cave_portal_cooldown - delta)
	update_combat_numbers(delta)
	if portal_cast_timer > 0.0:
		portal_cast_timer = maxf(0.0, portal_cast_timer - delta)
		if portal_cast_timer <= 0.0 and dead_timer <= 0.0:
			if dungeon_active == portal_cast_in_dungeon:
				sanctuary_portal_pos = portal_origin
				sanctuary_portal_in_dungeon = portal_cast_in_dungeon
				sanctuary_portal_time = PORTAL_LIFETIME
				# A player standing where the spell was cast must move out and back
				# into the portal; simply casting it cannot teleport instantly.
				sanctuary_portal_requires_exit = player.distance_to(sanctuary_portal_pos) <= SANCTUARY_PORTAL_RADIUS
				status_message = "Sanctuary portal opened! Walk inside (15 seconds)"
				status_timer = 2.1
			else:
				status_message = "Portal cast interrupted by changing areas"
				status_timer = 1.5
	update_sanctuary_portal(delta)
	for guard_index in range(guard_attack_flash.size()):
		guard_attack_flash[guard_index] = maxf(0.0, float(guard_attack_flash[guard_index]) - delta)
	if inventory_open or shop_open or bank_open or stat_window_open or oracle_open:
		queue_redraw()
		return
	lightning_clock += delta
	update_cosmetic_footprints(delta)
	for i in range(lightning_impacts.size() - 1, -1, -1):
		lightning_impacts[i]["time"] = float(lightning_impacts[i]["time"]) - delta
		if float(lightning_impacts[i]["time"]) <= 0.0:
			lightning_impacts.remove_at(i)
	attack_cooldown = maxf(0.0, attack_cooldown - delta)
	invulnerable = maxf(0.0, invulnerable - delta)
	# An ability stops immediately if its required equipment is unequipped.
	if knight_ability_timer > 0.0 and not knight_has_shield():
		knight_ability_timer = 0.0
	if bladestorm_timer > 0.0 and not knight_has_two_handed():
		bladestorm_timer = 0.0
	knight_ability_timer = maxf(0.0, knight_ability_timer - delta)
	knight_ability_spin += delta * 2.8
	if bladestorm_timer > 0.0:
		bladestorm_tick_timer -= delta
		while bladestorm_tick_timer <= 0.0 and bladestorm_timer > 0.0:
			bladestorm_damage_pulse()
			bladestorm_tick_timer += BLADESTORM_TICK
		bladestorm_timer = maxf(0.0, bladestorm_timer - delta)
		bladestorm_spin += delta * 3.6
	status_timer = maxf(0.0, status_timer - delta)
	fountain_heal_notice = maxf(0.0, fountain_heal_notice - delta)
	warrior_swing_timer = maxf(0.0, warrior_swing_timer - delta)
	warrior_slash_flash = maxf(0.0, warrior_slash_flash - delta)
	save_timer += delta
	if save_timer >= 5.0:
		save_slots()
		save_timer = 0.0
	if dead_timer > 0.0:
		portal_cast_timer = 0.0
		clear_sanctuary_portal()
		dead_timer -= delta
		if dead_timer <= 0.0:
			if dungeon_active:
				enemies.clear()
				projectiles.clear()
				enemy_projectiles.clear()
				drops.clear()
			dungeon_active = false
			player = TOWN
			current_zone_id = 0
			hp = max_hp
			invulnerable = 2.0
			status_message = "Respawned at the sanctuary"
			status_timer = 3.0
		queue_redraw()
		return
	if dungeon_active:
		update_dungeon_player(delta)
		if dungeon_active:
			if (pointer_held or mobile_fire or Input.is_key_pressed(KEY_SPACE)) and attack_cooldown <= 0.0:
				fire_attack()
			update_projectiles(delta)
			update_enemies(delta)
			update_morvex(delta)
			update_enemy_projectiles(delta)
			update_drops(delta)
		queue_redraw()
		return
	var previous_pos: Vector2 = player
	var move_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if left_touch != -1:
		move_dir = (joystick_current - joystick_origin).limit_length(65.0) / 65.0
	if move_dir.length() > 1.0:
		move_dir = move_dir.normalized()
	var speed: float = (205.0 if active_slot != 4 else 255.0) * movement_stat_multiplier()
	var desired: Vector2 = (player + move_dir * speed * delta).clamp(Vector2(24, 24), Vector2(WORLD_SIZE - 24, WORLD_SIZE - 24))
	# Prevent walking into the four unused corner squares of the cross layout.
	var safe_target: Vector2 = desired
	if not is_playable_ground(safe_target):
		safe_target = player
		var x_step: Vector2 = Vector2(desired.x, player.y)
		var y_step: Vector2 = Vector2(player.x, desired.y)
		if is_playable_ground(x_step):
			safe_target = x_step
		elif is_playable_ground(y_step):
			safe_target = y_step
	# Zone boundaries are solid except at their road gates.
	if not can_cross_zone_boundary(player, safe_target):
		safe_target = player
	player = move_player_through_gate(player, safe_target)
	update_bloody_footsteps(previous_pos)
	if current_zone_id == 0 and cave_portal_cooldown <= 0.0 and player.distance_to(FOREST_CAVE_POS) <= CAVE_PORTAL_RADIUS:
		enter_forest_dungeon()
		queue_redraw()
		return
	var entered_zone: int = zone_id_at(player)
	if entered_zone >= 0 and entered_zone != current_zone_id:
		current_zone_id = entered_zone
		status_message = "Entered " + zone_name(current_zone_id)
		status_timer = 3.0

	if mobile_fire and fire_stick_mode:
		var stick_direction: Vector2 = fire_stick_position - fire_stick_origin
		if stick_direction.length_squared() >= AIM_DEADZONE * AIM_DEADZONE:
			facing_direction = stick_direction.normalized()
	elif pointer_held or mobile_fire:
		var look_dir: Vector2 = aim_point - VIEW * 0.5
		if look_dir.length_squared() > 16.0:
			facing_direction = look_dir.normalized()
	elif move_dir.length_squared() > 0.01:
		facing_direction = move_dir.normalized()

	# Sanctuary's fountain restores health only while standing near it.
	if not inventory_open and player.distance_to(FOUNTAIN_POS) <= FOUNTAIN_HEAL_RADIUS and hp < max_hp:
		var before_fountain: float = hp
		hp = minf(max_hp, hp + FOUNTAIN_HEAL_PER_SECOND * delta)
		fountain_heal_accumulator += hp - before_fountain
		if fountain_heal_accumulator >= 9.0 or hp >= max_hp:
			show_combat_number(player, fountain_heal_accumulator, true)
			fountain_heal_accumulator = 0.0
		fountain_heal_notice = 0.5
	if (pointer_held or mobile_fire or Input.is_key_pressed(KEY_SPACE)) and attack_cooldown <= 0.0:
		fire_attack()
	spawn_timer += delta
	if spawn_timer >= 1.15 and enemies.size() < 28:
		spawn_timer = 0.0
		spawn_enemy()
	update_projectiles(delta)
	update_enemies(delta)
	update_enemy_projectiles(delta)
	update_drops(delta)
	queue_redraw()

# Morvex's collision shape follows his drawn body, wings and pointed ears.
# These visual strike surfaces do not restrict where players can walk.
func closest_point_on_capsule_surface(query: Vector2, a: Vector2, b: Vector2, radius: float) -> Vector2:
	var ab: Vector2 = b - a
	var fraction: float = clampf((query - a).dot(ab) / maxf(ab.length_squared(), 0.0001), 0.0, 1.0)
	var axis_point: Vector2 = a + ab * fraction
	var offset: Vector2 = query - axis_point
	var distance: float = offset.length()
	if distance <= radius:
		return query
	return axis_point + offset / distance * radius

func morvex_nearest_hit_point(query: Vector2) -> Vector2:
	var c: Vector2 = DUNGEON_BOSS_CENTER
	# The 74-pixel torso is handled before the much wider wing capsules.
	var nearest: Vector2 = closest_point_on_capsule_surface(query, c + Vector2(0, -17), c + Vector2(0, 22), 73.0)
	var best_sq: float = query.distance_squared_to(nearest)
	for side in [-1.0, 1.0]:
		var wing_segments: Array = [
			[c + Vector2(side * 44, -12), c + Vector2(side * 118, -56), 34.0],
			[c + Vector2(side * 118, -56), c + Vector2(side * 212, -84), 20.0],
			[c + Vector2(side * 118, -56), c + Vector2(side * 171, -14), 31.0],
			[c + Vector2(side * 171, -14), c + Vector2(side * 203, 47), 22.0],
			[c + Vector2(side * 118, -56), c + Vector2(side * 142, 66), 38.0],
			[c + Vector2(side * 142, 66), c + Vector2(side * 95, 48), 31.0],
			[c + Vector2(side * 44, -12), c + Vector2(side * 95, 48), 32.0],
			[c + Vector2(side * 20, -28), c + Vector2(side * 44, -84), 17.0],
			[c + Vector2(side * 36, -39), c + Vector2(side * 68, -109), 14.0],
			[c + Vector2(side * 42, 29), c + Vector2(side * 74, 73), 15.0]
		]
		for segment in wing_segments:
			var point: Vector2 = closest_point_on_capsule_surface(query, Vector2(segment[0]), Vector2(segment[1]), float(segment[2]))
			var dist_sq: float = query.distance_squared_to(point)
			if dist_sq < best_sq:
				best_sq = dist_sq
				nearest = point
	return nearest

func morvex_bullet_hit_fraction(start: Vector2, finish: Vector2) -> float:
	# Sample the swept travel path, avoiding missed hits at low mobile FPS.
	var samples: int = maxi(2, int(ceil(start.distance_to(finish) / 12.0)))
	for step in range(samples + 1):
		var t: float = float(step) / float(samples)
		var spot: Vector2 = start.lerp(finish, t)
		if spot.distance_squared_to(morvex_nearest_hit_point(spot)) <= 12.0 * 12.0:
			return t
	return -1.0

func fire_attack() -> void:
	var direction := facing_direction
	# Archer fires half as frequently as before. Two-handed Knight swords
	# have 70% of the one-handed attack rate (30% slower attack frequency).
	var attack_speed: float = [0.38, 0.44, 0.46, 0.55, 0.18][active_slot]
	if active_slot == 0 and is_two_handed_weapon(str(slots[active_slot]["equipment"].get("weapon", ""))):
		attack_speed /= 0.70
	attack_cooldown = attack_speed
	if active_slot == 0:
		warrior_swing_timer = WARRIOR_SWING_DURATION
		warrior_swing_direction = direction
		warrior_slash_flash = 0.10
		var two_handed: bool = is_two_handed_weapon(str(slots[active_slot]["equipment"].get("weapon", "")))
		var damage: float = knight_two_handed_damage()
		var swing_width: float = 220.0 if two_handed else WARRIOR_SWING_ARC_DEGREES
		var half_arc_cos: float = cos(deg_to_rad(swing_width * 0.5))
		var hit_any_enemy := false
		for i in range(enemies.size() - 1, -1, -1):
			var enemy: Dictionary = enemies[i]
			var boss_target: bool = int(enemy["type"]) == 2
			# For Morvex, aim at the closest part of the visible body or wings.
			var hit_location: Vector2 = morvex_nearest_hit_point(player) if boss_target else Vector2(enemy["pos"])
			var to_enemy: Vector2 = hit_location - player
			var distance: float = to_enemy.length()
			var attack_range: float = WARRIOR_SWING_RANGE * (2.0 if two_handed else 1.0)
			if distance <= attack_range:
				var dir_to_enemy: Vector2 = to_enemy / maxf(distance, 0.001)
				var within_swing: bool = dir_to_enemy.dot(direction) >= half_arc_cos
				if within_swing:
					var health_before: float = float(enemy["hp"])
					var is_critical: bool = roll_critical_hit()
					var strike_damage: float = critical_damage(damage, is_critical)
					enemy["hp"] = maxf(0.0, health_before - strike_damage)
					var damage_done: float = health_before - float(enemy["hp"])
					if damage_done > 0.0:
						hit_any_enemy = true
						show_combat_number(hit_location if boss_target else Vector2(enemy["pos"]), damage_done, false, is_critical)
						add_knight_ability_charge(1)
						enemy["hit_flash"] = 0.18
						if not boss_target:
							enemy["pos"] += dir_to_enemy * 12.0
						enemies[i] = enemy
						if float(enemy["hp"]) <= 0.0:
							defeat_enemy(i)
		# The God Sword's lightning seeks the nearest living enemy within 5 tiles.
		# It hits the selected target directly, rather than flying forward at random.
		if hit_any_enemy and item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "god_sword":
			strike_god_sword_lightning()
		return
	if active_slot == 4:
		# Rogue attacks in close melee with one or two separately equipped daggers.
		# Offhand dagger gets its own critical hit roll and damage application.
		var dagger_equipment: Dictionary = slots[active_slot]["equipment"]
		var mainhand_id: String = str(dagger_equipment.get("weapon", ""))
		var offhand_id: String = str(dagger_equipment.get("offhand", ""))
		var mainhand_power: float = 8.0 + melee_stat_bonus() + float(ITEM_DATA.get(mainhand_id, {}).get("atk", 0))
		var twin_strikes: int = 2 if item_base_id(offhand_id) == "rogue_offhand_dagger" else 1
		for i in range(enemies.size() - 1, -1, -1):
			var enemy: Dictionary = enemies[i]
			var boss_target: bool = int(enemy["type"]) == 2
			var hit_location: Vector2 = morvex_nearest_hit_point(player) if boss_target else Vector2(enemy["pos"])
			var to_enemy: Vector2 = hit_location - player
			var distance: float = to_enemy.length()
			if distance > 75.0:
				continue
			var heading: Vector2 = to_enemy / maxf(distance, 0.001)
			if heading.dot(direction) < 0.0:
				continue
			for strike in range(twin_strikes):
				if float(enemy["hp"]) <= 0.0:
					break
				var hit_damage: float = mainhand_power if strike == 0 else (5.0 + float(ITEM_DATA.get(offhand_id, {}).get("atk", 0)) + melee_stat_bonus() * 0.5)
				var is_critical: bool = roll_critical_hit()
				var actual: float = minf(float(enemy["hp"]), critical_damage(hit_damage, is_critical))
				enemy["hp"] = maxf(0.0, float(enemy["hp"]) - actual)
				show_combat_number(hit_location, actual, false, is_critical)
				enemy["hit_flash"] = 0.18
			enemies[i] = enemy
			if float(enemy["hp"]) <= 0.0:
				defeat_enemy(i)
		return
	var spread_count := 3 if active_slot == 2 else 1
	for n in range(spread_count):
		var dir := direction.rotated((n - (spread_count - 1) * 0.5) * 0.19)
		var range_value := 450.0
		var scaling_damage: float = magic_stat_bonus() if active_slot == 2 or active_slot == 3 else ranged_stat_bonus()
		var damage: float = float([20.0, 13.0, 15.0, 13.0, 11.0][active_slot]) + scaling_damage + float(get_equipment_bonus("atk"))
		projectiles.append({"pos": player + dir * 17.0, "velocity": dir * 520.0, "life": range_value / 520.0, "damage": damage, "friendly": true, "color": COLORS[active_slot], "green_arrow": active_slot == 1})
	if active_slot == 3:
		var before_priest: float = hp
		hp = minf(max_hp, hp + 1.0)
		show_combat_number(player, hp - before_priest, true)

func strike_god_sword_lightning() -> void:
	# One lightning strike per successful sword swing, not one per enemy hit.
	# The range is measured from the player to the closest visible part of a boss.
	var nearest_index: int = -1
	var nearest_dist_sq: float = GOD_SWORD_LIGHTNING_RANGE * GOD_SWORD_LIGHTNING_RANGE
	var target_pos: Vector2 = Vector2.ZERO
	for i in range(enemies.size()):
		var enemy: Dictionary = enemies[i]
		if float(enemy.get("hp", 0.0)) <= 0.0:
			continue
		var aim: Vector2 = morvex_nearest_hit_point(player) if int(enemy["type"]) == 2 else Vector2(enemy["pos"])
		var dist_sq: float = player.distance_squared_to(aim)
		if dist_sq <= nearest_dist_sq:
			nearest_dist_sq = dist_sq
			nearest_index = i
			target_pos = aim
	if nearest_index < 0:
		return
	var victim: Dictionary = enemies[nearest_index]
	var before: float = float(victim["hp"])
	var is_critical: bool = roll_critical_hit()
	var damage: float = critical_damage(GOD_SWORD_LIGHTNING_DAMAGE + magic_stat_bonus(), is_critical)
	victim["hp"] = maxf(0.0, before - damage)
	var dealt: float = before - float(victim["hp"])
	if dealt > 0.0:
		show_combat_number(target_pos, dealt, false, is_critical)
		add_knight_ability_charge(1)
	victim["hit_flash"] = 0.17
	enemies[nearest_index] = victim
	# A bright, branching, animated lightning arc from sword to the chosen foe.
	lightning_impacts.append({"pos": target_pos, "start": player + Vector2(0.0, -12.0), "time": 0.23})
	if float(victim["hp"]) <= 0.0:
		defeat_enemy(nearest_index)

func spawn_enemy() -> void:
	var angle: float = world_rng.randf_range(0.0, TAU)
	var distance: float = world_rng.randf_range(360.0, 500.0)
	# Initial version: familiar wolves and bats are Forest creatures only.
	# The four new biomes are explorable now; biome-specific enemies come later.
	if zone_id_at(player) != 0:
		return
	var point: Vector2 = player + Vector2.RIGHT.rotated(angle) * distance
	if zone_id_at(point) != 0 or castle_rect().grow(ENEMY_CLEARANCE).has_point(point):
		return
	# Keep the original color mapping: 0=red wolf, 1=purple bat.
	# Both monsters can spawn throughout the wilderness.
	var enemy_type: int = 1 if world_rng.randf() < 0.38 else 0
	var health: float = 36.0 if enemy_type == 0 else 26.0
	var movement_speed: float = 112.0 if enemy_type == 0 else 94.0
	enemies.append({"pos": point, "hp": health, "max_hp": health,
		"speed": movement_speed, "damage": WOLF_BITE_DAMAGE if enemy_type == 0 else BAT_BOLT_DAMAGE,
		"type": enemy_type, "level": WOLF_LEVEL if enemy_type == 0 else BAT_LEVEL,
		"hit_cd": 0.0, "hit_flash": 0.0,
		"shoot_cd": world_rng.randf_range(0.35, 1.2), "facing": Vector2.DOWN})

func update_projectiles(delta: float) -> void:
	for i in range(projectiles.size() - 1, -1, -1):
		var shot: Dictionary = projectiles[i]
		var previous: Vector2 = shot["pos"]
		var next_position: Vector2 = previous + shot["velocity"] * delta
		shot["life"] = float(shot["life"]) - delta
		if dungeon_active and not dungeon_floor_at(next_position):
			projectiles.remove_at(i)
			continue
		if bool(shot.get("lightning", false)):
			shot["age"] = float(shot.get("age", 0.0)) + delta
		var segment: Vector2 = next_position - previous
		var segment_length_squared := segment.length_squared()
		var hit_index := -1
		var closest_hit_fraction := 2.0
		for j in range(enemies.size()):
			var enemy: Dictionary = enemies[j]
			var target: Vector2 = Vector2(enemy["pos"])
			var fraction: float = 0.0
			if int(enemy["type"]) == 2:
				fraction = morvex_bullet_hit_fraction(previous, next_position)
			else:
				if segment_length_squared > 0.0001:
					fraction = clampf((target - previous).dot(segment) / segment_length_squared, 0.0, 1.0)
				var closest_point: Vector2 = previous + segment * fraction
				var hit_radius: float = 32.0 if dungeon_active and int(enemy["type"]) == 1 else 19.0
				if closest_point.distance_squared_to(target) > hit_radius * hit_radius:
					fraction = -1.0
			if fraction >= 0.0 and fraction < closest_hit_fraction:
				hit_index = j
				closest_hit_fraction = fraction
		if hit_index != -1:
			if bool(shot.get("lightning", false)):
				lightning_impacts.append({"pos": enemies[hit_index]["pos"], "time": 0.23})
			var enemy: Dictionary = enemies[hit_index]
			var health_before: float = float(enemy["hp"])
			var is_critical: bool = roll_critical_hit()
			var projectile_damage: float = critical_damage(float(shot["damage"]), is_critical)
			enemy["hp"] = maxf(0.0, health_before - projectile_damage)
			var actual_projectile_damage: float = health_before - float(enemy["hp"])
			if actual_projectile_damage > 0.0:
				show_combat_number(Vector2(enemy["pos"]), actual_projectile_damage, false, is_critical)
				if active_slot == 0:
					add_knight_ability_charge(1)
			enemy["hit_flash"] = 0.15
			enemies[hit_index] = enemy
			if float(enemy["hp"]) <= 0.0:
				defeat_enemy(hit_index)
			projectiles.remove_at(i)
		elif float(shot["life"]) <= 0.0:
			projectiles.remove_at(i)
		else:
			shot["pos"] = next_position
			projectiles[i] = shot

func roll_elixer_drop(monster_pos: Vector2) -> void:
	# 5% per kill total, evenly shared by the five listed varieties.
	if world_rng.randf() >= minf(1.0, ELIXER_DROP_CHANCE + item_drop_bonus()):
		return
	var index: int = world_rng.randi_range(0, ELIXER_TYPES.size() - 1)
	var elixer_id: String = "elixer_" + str(ELIXER_TYPES[index]).to_lower()
	drops.append({"pos": monster_pos + Vector2(17.0, 17.0), "elixer": elixer_id, "ttl": GROUND_DROP_LIFETIME})

func defeat_enemy(index: int) -> void:
	var enemy: Dictionary = enemies[index]
	if int(enemy["type"]) == 2:
		# Morvex always drops exactly one random Tier 2 equipment piece
		# from the current character's legal gear pool; never a God Sword.
		var armor_pool: Array = class_equipment_drop_pool(active_slot)
		var reward_id: String = str(armor_pool[world_rng.randi_range(0, armor_pool.size() - 1)]) + "_t2"
		drops.append({"pos": DUNGEON_BOSS_CENTER + Vector2(20, 60), "item": reward_id, "ttl": GROUND_DROP_LIFETIME})
		# Separate guaranteed cosmetic reward, alongside normal Tier 2 loot.
		drops.append({"pos": DUNGEON_BOSS_CENTER + Vector2(-44, 64), "item": "bloody_footprints", "ttl": GROUND_DROP_LIFETIME})
		enemies.remove_at(index)
		morvex_defeated = true
		blood_bat_spawn_timer = 0.0
		morvex_windup_timer = 0.0
		morvex_attack_telegraph = -1
		# Remove existing red waves when the boss dies.
		for i in range(enemy_projectiles.size() - 1, -1, -1):
			if bool(enemy_projectiles[i].get("sonic", false)):
				enemy_projectiles.remove_at(i)
		kills += 1
		slots[active_slot]["kills"] = kills
		grant_kill_experience(MORVEX_XP)
		roll_elixer_drop(DUNGEON_BOSS_CENTER)
		status_message = "MORVEX DEFEATED! Tier 2 gear + Bloody Footprints dropped!"
		status_timer = 5.0
		save_slots()
		return
	# Independent loot rolls, each boosted by the player's Luck stat.
	# There is no guaranteed drop on a player kill.
	if world_rng.randf() < minf(1.0, GOLD_DROP_CHANCE + item_drop_bonus()):
		drops.append({"pos": enemy["pos"], "gold": 4 if enemy["type"] == 1 else 2, "ttl": GROUND_DROP_LIFETIME})
	if world_rng.randf() < minf(1.0, POTION_DROP_CHANCE + item_drop_bonus()):
		var potion_pos: Vector2 = enemy["pos"] + Vector2(20.0, -7.0)
		drops.append({"pos": potion_pos, "gold": 0, "potion": true, "ttl": GROUND_DROP_LIFETIME})
	roll_elixer_drop(Vector2(enemy["pos"]))
	# Rare equipment drops, independently rolled and improved by Luck.
	if world_rng.randf() < minf(1.0, GEAR_DROP_CHANCE + item_drop_bonus()):
		var candidates: Array = class_equipment_drop_pool(active_slot)
		var item_id: String = str(candidates[world_rng.randi_range(0, candidates.size() - 1)])
		if int(enemy.get("level", 0)) >= 10:
			item_id += "_t2"
		drops.append({"pos": enemy["pos"] + Vector2(-20.0, 12.0), "item": item_id, "ttl": GROUND_DROP_LIFETIME})
	enemies.remove_at(index)
	kills += 1
	slots[active_slot]["kills"] = kills
	grant_kill_experience(6 if int(enemy["type"]) == 1 else 10)

func grant_kill_experience(amount: int) -> void:
	if int(slots[active_slot]["level"]) < LEVEL_CAP:
		slots[active_slot]["xp"] = int(slots[active_slot]["xp"]) + amount
		while int(slots[active_slot]["level"]) < LEVEL_CAP and int(slots[active_slot]["xp"]) >= xp_needed(int(slots[active_slot]["level"])):
			slots[active_slot]["xp"] = int(slots[active_slot]["xp"]) - xp_needed(int(slots[active_slot]["level"]))
			slots[active_slot]["level"] = int(slots[active_slot]["level"]) + 1
			slots[active_slot]["stat_points"] = int(slots[active_slot]["stat_points"]) + STAT_POINTS_PER_LEVEL
			status_message = "LEVEL UP! +5 STAT POINTS - Open Attributes"
			status_timer = 3.0
			save_slots()
		if int(slots[active_slot]["level"]) >= LEVEL_CAP:
			slots[active_slot]["xp"] = 0

func xp_needed(level: int) -> int:
	if level >= LEVEL_CAP:
		return 0
	return 10 * (50 + (level - 1) * 30)

func update_enemies(delta: float) -> void:
	for i in range(enemies.size() - 1, -1, -1):
		var enemy: Dictionary = enemies[i]
		var enemy_pos: Vector2 = enemy["pos"]
		if enemy_pos.distance_to(player) > 880.0:
			if dungeon_active:
				continue
			enemies.remove_at(i)
			continue
		enemy["hit_cd"] = maxf(0.0, float(enemy["hit_cd"]) - delta)
		enemy["hit_flash"] = maxf(0.0, float(enemy.get("hit_flash", 0.0)) - delta)
		var distance: float = enemy_pos.distance_to(player)
		var to_player: Vector2 = player - enemy_pos
		var facing: Vector2 = to_player.normalized() if distance > 0.001 else Vector2.DOWN
		enemy["facing"] = facing
		if int(enemy["type"]) == 2:
			enemies[i] = enemy
			continue
		if int(enemy["type"]) == 0:
			# Wolf: close in and bite. It never creates a projectile.
			if distance > 24.0 and distance < 560.0:
				enemy_pos += facing * float(enemy["speed"]) * delta
		else:
			# Bat: hover around ranged distance and retreat if approached.
			enemy["shoot_cd"] = maxf(0.0, float(enemy["shoot_cd"]) - delta)
			if distance < 145.0 and distance > 0.001:
				enemy_pos -= facing * float(enemy["speed"]) * delta
			elif distance > BAT_PREFERRED_DISTANCE + 45.0 and distance < 560.0:
				enemy_pos += facing * float(enemy["speed"]) * delta
		# Outdoor enemies cannot enter Sanctuary; cave bats stay inside tunnels.
		if dungeon_active:
			if not dungeon_can_walk(enemy_pos):
				enemy_pos = Vector2(enemy["pos"])
		else:
			enemy_pos = keep_enemy_outside_castle(enemy_pos, Vector2(enemy["pos"]))
		enemy["pos"] = enemy_pos
		# Castle guards instantly defeat monsters reaching the drawbridge.
		# Remove them directly: no loot, gold, experience or kill count.
		var killed_by_guard := false
		for guard_index in range(GUARD_POSITIONS.size() if not dungeon_active else 0):
			var guard_position: Vector2 = TOWN + GUARD_POSITIONS[guard_index]
			if enemy_pos.distance_squared_to(guard_position) <= GUARD_RADIUS * GUARD_RADIUS:
				guard_attack_flash[guard_index] = 0.25
				enemies.remove_at(i)
				killed_by_guard = true
				break
		if killed_by_guard:
			continue
		distance = enemy_pos.distance_to(player)
		if int(enemy["type"]) == 0:
			# Only wolves can cause contact damage.
			if distance < 31.0 and not is_in_sanctuary(player) and float(enemy["hit_cd"]) <= 0.0 and invulnerable <= 0.0:
				apply_enemy_damage(WOLF_BITE_DAMAGE)
				enemy["hit_cd"] = 0.95
		else:
			# Bats only shoot; touching a bat never damages the player.
			if distance <= BAT_ATTACK_RANGE and distance > 0.001 and float(enemy["shoot_cd"]) <= 0.0 and not is_in_sanctuary(player):
				var aim: Vector2 = (player - enemy_pos).normalized()
				enemy_projectiles.append({"pos": enemy_pos + aim * 16.0, "velocity": aim * BAT_BOLT_SPEED,
					"life": 1.8, "damage": float(enemy["damage"])})
				enemy["shoot_cd"] = BAT_FIRE_INTERVAL + world_rng.randf_range(-0.2, 0.3)
		enemies[i] = enemy

func apply_enemy_damage(raw_damage: float) -> void:
	if dead_timer > 0.0 or invulnerable > 0.0 or is_in_sanctuary(player) or knight_ability_timer > 0.0:
		return
	var health_before: float = hp
	var defense: float = maxf(0.0, float(get_equipment_bonus("def")))
	var mitigated_damage: float = raw_damage * 100.0 / (100.0 + defense * 3.0)
	hp = maxf(0.0, hp - maxf(0.0, mitigated_damage))
	show_combat_number(player, health_before - hp)
	add_knight_ability_charge(1)
	invulnerable = 0.35
	if hp <= 0.0:
		hp = 0.0
		# Hardcore inventory loss: equipped items and vault storage survive.
		# Nothing is dropped at the death site for later retrieval.
		slots[active_slot]["gold"] = 0
		slots[active_slot]["bag"] = []
		selected_bag_index = -1
		inventory_open = false
		bank_open = false
		dead_timer = 3.0
		status_message = "You died: carried gold and backpack items lost!"
		status_timer = 3.0
		save_slots()

func update_enemy_projectiles(delta: float) -> void:
	for i in range(enemy_projectiles.size() - 1, -1, -1):
		var shot: Dictionary = enemy_projectiles[i]
		var previous: Vector2 = shot["pos"]
		var next_pos: Vector2 = previous + Vector2(shot["velocity"]) * delta
		shot["life"] = float(shot["life"]) - delta
		# Castle ward absorbs bat projectiles before they enter the safe rectangle.
		if dungeon_active:
			if not dungeon_floor_at(next_pos):
				enemy_projectiles.remove_at(i)
				continue
		elif bolt_crosses_sanctuary(previous, next_pos):
			enemy_projectiles.remove_at(i)
			continue
		# Swept collision against the player to prevent skipped hits on mobile.
		var segment: Vector2 = next_pos - previous
		var segment_length_sq: float = segment.length_squared()
		var hit_fraction: float = 0.0
		if segment_length_sq > 0.0001:
			hit_fraction = clampf((player - previous).dot(segment) / segment_length_sq, 0.0, 1.0)
		var closest: Vector2 = previous + segment * hit_fraction
		var radius: float = 21.0 if bool(shot.get("sonic", false)) else 18.0
		if closest.distance_squared_to(player) <= radius * radius:
			apply_enemy_damage(float(shot["damage"]))
			enemy_projectiles.remove_at(i)
		elif float(shot["life"]) <= 0.0:
			enemy_projectiles.remove_at(i)
		else:
			shot["pos"] = next_pos
			enemy_projectiles[i] = shot

func nearest_ground_item_index() -> int:
	var closest: int = -1
	var best_distance: float = LOOT_REACH * LOOT_REACH
	for i in range(drops.size()):
		var drop: Dictionary = drops[i]
		if not drop.has("item"):
			continue
		var distance: float = player.distance_squared_to(Vector2(drop["pos"]))
		if distance <= best_distance:
			closest = i
			best_distance = distance
	return closest

func pickup_nearby_equipment() -> void:
	if active_slot < 0 or dead_timer > 0.0:
		return
	var drop_index: int = nearest_ground_item_index()
	if drop_index < 0:
		return
	var item_id: String = str(drops[drop_index]["item"])
	if add_item_to_bag(item_id):
		status_message = "Looted " + str(ITEM_DATA[item_id]["name"])
		status_timer = 2.2
		drops.remove_at(drop_index)
	else:
		status_message = "Backpack full! Deposit items at the Banker."
		status_timer = 2.2
	queue_redraw()

func update_drops(delta: float) -> void:
	for i in range(drops.size() - 1, -1, -1):
		var loot: Dictionary = drops[i]
		loot["ttl"] = float(loot.get("ttl", GROUND_DROP_LIFETIME)) - delta
		if float(loot["ttl"]) <= 0.0:
			drops.remove_at(i)
			continue
		drops[i] = loot
		var loot_pos: Vector2 = Vector2(loot["pos"])
		if loot.has("item"):
			# Equipment and cosmetics never auto-pick up, even when standing directly on them.
			continue
		if player.distance_squared_to(loot_pos) > PICKUP_RADIUS * PICKUP_RADIUS:
			continue
		if loot.has("elixer"):
			var elixer_id: String = str(loot["elixer"])
			if add_item_to_bag(elixer_id):
				status_message = "Collected " + str(ITEM_DATA[elixer_id]["name"])
				status_timer = 1.6
				drops.remove_at(i)
			else:
				status_message = "Backpack full - cannot pick up Elixer"
				status_timer = 1.5
			continue
		if bool(loot.get("potion", false)):
			if hp >= max_hp:
				continue
			var recovered: float = minf(POTION_HEAL_AMOUNT, max_hp - hp)
			hp += recovered
			show_combat_number(player, recovered, true)
			status_message = "Health potion +%d HP" % int(recovered)
			status_timer = 1.5
		else:
			slots[active_slot]["gold"] += int(loot["gold"])
		drops.remove_at(i)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if oracle_open:
			if event.pressed:
				handle_oracle_tap(event.position - (VIEW - DESIGN_VIEW) * 0.5)
			return
		if bank_open:
			if event.pressed:
				handle_bank_tap(event.position)
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and not shop_open and dead_timer <= 0.0 and LOOT_BUTTON.has_point(event.position) and nearest_ground_item_index() >= 0:
			pickup_nearby_equipment()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and not shop_open and not bank_open and player.distance_to(ORACLE_POS) <= ORACLE_TALK_RADIUS and (ORACLE_BUTTON.has_point(event.position) or event.position.distance_to(ORACLE_POS - (player - VIEW * 0.5)) <= 39.0):
			open_oracle()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and not shop_open and player.distance_to(BANKER_POS) <= BANKER_TALK_RADIUS and (BANKER_BUTTON.has_point(event.position) or event.position.distance_to(BANKER_POS - (player - VIEW * 0.5)) <= 39.0):
			open_bank()
			return
		if shop_open:
			if event.pressed:
				handle_shop_tap(event.position)
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not shop_open and PORTAL_BUTTON.has_point(event.position):
			start_portal_cast()
			return
		if event.pressed and active_slot == 0 and not inventory_open and not shop_open and not stat_window_open and KNIGHT_ABILITY_BUTTON.has_point(event.position):
			activate_knight_ability()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and STAT_BUTTON.has_point(event.position):
			toggle_stats_window()
			return
		if stat_window_open:
			if event.pressed:
				handle_stat_tap(event.position)
			return
		if event.pressed and active_slot >= 0 and not inventory_open and SHOP_BUTTON.has_point(event.position) and player.distance_to(SWORD_MERCHANT_POS) <= MERCHANT_TALK_RADIUS:
			open_shop()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and event.position.distance_to(SWORD_MERCHANT_POS - (player - VIEW * 0.5)) <= 39.0 and player.distance_to(SWORD_MERCHANT_POS) <= MERCHANT_TALK_RADIUS:
			open_shop()
			return
		if event.pressed and active_slot >= 0 and (inventory_open or INVENTORY_BUTTON.has_point(event.position)):
			handle_inventory_tap(event.position)
			return
		if inventory_open:
			return
		if event.pressed:
			if active_slot < 0:
				handle_character_menu_tap(event.position - (VIEW - DESIGN_VIEW) * 0.5)
			elif event.position.x < VIEW.x * 0.46 and event.position.y > 175.0 and left_touch == -1:
				left_touch = event.index
				joystick_origin = event.position
				joystick_current = event.position
			elif right_touch == -1:
				right_touch = event.index
				aim_point = event.position
				mobile_fire = true
				fire_stick_mode = event.position.distance_to(FIRE_CENTER) <= FIRE_TOUCH_RADIUS
				fire_stick_origin = event.position
				fire_stick_position = event.position
		else:
			if event.index == left_touch:
				left_touch = -1
			if event.index == right_touch:
				right_touch = -1
				mobile_fire = false
				fire_stick_mode = false
	elif event is InputEventScreenDrag:
		if inventory_open or shop_open or bank_open or stat_window_open or oracle_open:
			return
		if event.index == left_touch:
			joystick_current = event.position
		elif event.index == right_touch:
			aim_point = event.position
			fire_stick_position = event.position
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if oracle_open:
			if event.pressed:
				handle_oracle_tap(event.position - (VIEW - DESIGN_VIEW) * 0.5)
			return
		if bank_open:
			if event.pressed:
				handle_bank_tap(event.position)
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and not shop_open and dead_timer <= 0.0 and LOOT_BUTTON.has_point(event.position) and nearest_ground_item_index() >= 0:
			pickup_nearby_equipment()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and not shop_open and not bank_open and player.distance_to(ORACLE_POS) <= ORACLE_TALK_RADIUS and (ORACLE_BUTTON.has_point(event.position) or event.position.distance_to(ORACLE_POS - (player - VIEW * 0.5)) <= 39.0):
			open_oracle()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and not shop_open and player.distance_to(BANKER_POS) <= BANKER_TALK_RADIUS and (BANKER_BUTTON.has_point(event.position) or event.position.distance_to(BANKER_POS - (player - VIEW * 0.5)) <= 39.0):
			open_bank()
			return
		if shop_open:
			if event.pressed:
				handle_shop_tap(event.position)
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not shop_open and PORTAL_BUTTON.has_point(event.position):
			start_portal_cast()
			return
		if event.pressed and active_slot == 0 and not inventory_open and not shop_open and not stat_window_open and KNIGHT_ABILITY_BUTTON.has_point(event.position):
			activate_knight_ability()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and not stat_window_open and STAT_BUTTON.has_point(event.position):
			toggle_stats_window()
			return
		if stat_window_open:
			if event.pressed:
				handle_stat_tap(event.position)
			return
		if event.pressed and active_slot >= 0 and not inventory_open and SHOP_BUTTON.has_point(event.position) and player.distance_to(SWORD_MERCHANT_POS) <= MERCHANT_TALK_RADIUS:
			open_shop()
			return
		if event.pressed and active_slot >= 0 and not inventory_open and event.position.distance_to(SWORD_MERCHANT_POS - (player - VIEW * 0.5)) <= 39.0 and player.distance_to(SWORD_MERCHANT_POS) <= MERCHANT_TALK_RADIUS:
			open_shop()
			return
		if event.pressed and active_slot >= 0 and (inventory_open or INVENTORY_BUTTON.has_point(event.position)):
			handle_inventory_tap(event.position)
			return
		if inventory_open:
			return
		if active_slot < 0 and event.pressed:
			handle_character_menu_tap(event.position - (VIEW - DESIGN_VIEW) * 0.5)
		else:
			pointer_held = event.pressed
			aim_point = event.position
	elif event is InputEventMouseMotion and pointer_held and not inventory_open and not bank_open and not stat_window_open:
		aim_point = event.position
	elif event is InputEventKey and event.pressed and not event.echo:
		if active_slot < 0 and reset_slot_pending == -1 and event.keycode >= KEY_1 and event.keycode <= KEY_5:
			preview_slot = int(event.keycode - KEY_1)
			queue_redraw()
		elif active_slot < 0 and reset_slot_pending == -1 and event.keycode == KEY_ENTER:
			select_slot(preview_slot)
		elif active_slot >= 0 and event.keycode == KEY_Q and not inventory_open and not shop_open and not bank_open and not stat_window_open:
			activate_knight_ability()
		elif active_slot >= 0 and event.keycode == KEY_C and not bank_open:
			toggle_stats_window()
		elif active_slot >= 0 and event.keycode == KEY_ESCAPE and stat_window_open:
			toggle_stats_window()
		elif active_slot >= 0 and event.keycode == KEY_I and not bank_open and not stat_window_open:
			toggle_inventory()
		elif active_slot >= 0 and event.keycode == KEY_ESCAPE and bank_open:
			close_bank()
		elif active_slot >= 0 and event.keycode == KEY_E and not inventory_open and not shop_open and not bank_open and dead_timer <= 0.0 and nearest_ground_item_index() >= 0:
			pickup_nearby_equipment()
		elif active_slot >= 0 and event.keycode == KEY_O and not inventory_open and not shop_open and not bank_open and not stat_window_open and player.distance_to(ORACLE_POS) <= ORACLE_TALK_RADIUS:
			open_oracle()
		elif active_slot >= 0 and event.keycode == KEY_ESCAPE and oracle_open:
			close_oracle()
		elif active_slot >= 0 and event.keycode == KEY_B and not inventory_open and not shop_open and not bank_open and player.distance_to(BANKER_POS) <= BANKER_TALK_RADIUS:
			open_bank()
		elif active_slot >= 0 and event.keycode == KEY_ESCAPE and shop_open:
			shop_open = false
		elif active_slot >= 0 and event.keycode == KEY_ESCAPE and inventory_open:
			toggle_inventory()
		elif active_slot >= 0 and event.keycode == KEY_ESCAPE:
			portal_cast_timer = 0.0
			clear_sanctuary_portal()
			save_slots()
			preview_slot = active_slot
			active_slot = -1
			pointer_held = false
			mobile_fire = false
			fire_stick_mode = false
			left_touch = -1
			right_touch = -1

func choose_from_position(pos: Vector2) -> void:
	for i in range(CLASSES.size()):
		var r: Rect2 = Rect2(CHARACTER_SELECT_ORIGIN + Vector2(0, float(i) * CHARACTER_SELECT_STEP), CHARACTER_SELECT_ROW_SIZE)
		if r.has_point(pos):
			preview_slot = i
			queue_redraw()
			return

func open_shop() -> void:
	if active_slot < 0 or inventory_open:
		return
	if player.distance_to(SWORD_MERCHANT_POS) > MERCHANT_TALK_RADIUS:
		return
	shop_open = true
	left_touch = -1
	right_touch = -1
	pointer_held = false
	mobile_fire = false
	fire_stick_mode = false
	queue_redraw()

func handle_shop_tap(pos: Vector2) -> void:
	if SHOP_CLOSE_BUTTON.has_point(pos) or not Rect2(111, 72, 738, 385).has_point(pos):
		shop_open = false
		queue_redraw()
		return
	if not SHOP_BUY_BUTTON.has_point(pos):
		return
	if active_slot != 0:
		status_message = "God Sword requires the Knight class"
	elif int(slots[active_slot]["gold"]) < GOD_SWORD_PRICE:
		status_message = "Not enough gold (100 needed)"
	elif find_space("god_sword").x < 0:
		status_message = "Backpack is full - free space first"
	elif add_item_to_bag("god_sword"):
		slots[active_slot]["gold"] = int(slots[active_slot]["gold"]) - GOD_SWORD_PRICE
		save_slots()
		status_message = "Purchased God Sword! Open bag to equip it"
	else:
		status_message = "Could not add God Sword"
	status_timer = 3.0
	shop_open = false
	queue_redraw()

func oracle_refundable_points() -> int:
	if active_slot < 0:
		return 0
	var allocated: int = 0
	var ledger: Dictionary = slots[active_slot]["level_stats"]
	for stat_key in STAT_KEYS:
		allocated += int(ledger.get(stat_key, 0))
	return allocated

func open_oracle() -> void:
	if active_slot < 0 or dungeon_active or dead_timer > 0.0 or inventory_open or shop_open or bank_open or stat_window_open or oracle_open:
		return
	if player.distance_to(ORACLE_POS) > ORACLE_TALK_RADIUS:
		return
	oracle_open = true
	left_touch = -1
	right_touch = -1
	pointer_held = false
	mobile_fire = false
	fire_stick_mode = false
	queue_redraw()

func close_oracle() -> void:
	oracle_open = false
	queue_redraw()

func confirm_oracle_respec() -> void:
	if active_slot < 0:
		return
	var refund: int = oracle_refundable_points()
	if refund <= 0:
		status_message = "No tracked level points to reset"
		status_timer = 3.0
		close_oracle()
		return
	if int(slots[active_slot]["gold"]) < ORACLE_RESPEC_COST:
		status_message = "Oracle requires 100 carried gold"
		status_timer = 3.0
		close_oracle()
		return
	var old_max_hp: float = max_hp
	var stats: Dictionary = slots[active_slot]["stats"]
	var ledger: Dictionary = slots[active_slot]["level_stats"]
	for stat_key in STAT_KEYS:
		var allocated: int = int(ledger.get(stat_key, 0))
		stats[stat_key] = maxi(0, int(stats.get(stat_key, 0)) - allocated)
		ledger[stat_key] = 0
	slots[active_slot]["stat_points"] = int(slots[active_slot]["stat_points"]) + refund
	slots[active_slot]["gold"] = int(slots[active_slot]["gold"]) - ORACLE_RESPEC_COST
	max_hp = character_max_hp()
	# Removing Hitpoints investments must clamp, never artificially heal.
	hp = minf(hp, max_hp)
	status_message = "Oracle refunded %d level points for 100 gold" % refund
	status_timer = 3.5
	close_oracle()
	save_slots()
	queue_redraw()

func handle_oracle_tap(point: Vector2) -> void:
	if ORACLE_CONFIRM_BUTTON.has_point(point):
		confirm_oracle_respec()
	elif ORACLE_CANCEL_BUTTON.has_point(point) or not ORACLE_PANEL.has_point(point):
		close_oracle()

func draw_oracle_panel() -> void:
	draw_rect(ORACLE_PANEL, Color("14192c"))
	draw_rect(ORACLE_PANEL, Color("ada3ed"), false, 3.0)
	draw_label("ORACLE - STAT REASSIGNMENT", Vector2(248, 164), 24, Color("e7deff"))
	draw_label("Reset your level-up attribute points?", Vector2(258, 213), 19, Color("f1eaff"))
	draw_label("Cost: 100 carried gold", Vector2(311, 250), 19, Color("ffdc8c"))
	draw_label("Points refunded: %d" % oracle_refundable_points(), Vector2(322, 281), 19, Color("bcebd0"))
	draw_rect(ORACLE_CONFIRM_BUTTON, Color("4a735b"))
	draw_rect(ORACLE_CONFIRM_BUTTON, Color("9ee3a6"), false, 2.0)
	draw_label("RESET", Vector2(328, 355), 21, Color("ffffff"))
	draw_rect(ORACLE_CANCEL_BUTTON, Color("69475d"))
	draw_rect(ORACLE_CANCEL_BUTTON, Color("deb5d6"), false, 2.0)
	draw_label("CANCEL", Vector2(550, 355), 21, Color("ffffff"))
	draw_label("Elixer bonuses remain permanently intact.", Vector2(289, 402), 16, Color("bcb8e3"))

func open_bank() -> void:
	if active_slot < 0 or dungeon_active or dead_timer > 0.0 or inventory_open or shop_open:
		return
	if player.distance_to(BANKER_POS) > BANKER_TALK_RADIUS:
		return
	bank_open = true
	bank_page = 0
	bank_selected_bag = -1
	bank_selected_vault = -1
	left_touch = -1
	right_touch = -1
	pointer_held = false
	mobile_fire = false
	fire_stick_mode = false
	queue_redraw()

func close_bank() -> void:
	bank_open = false
	bank_selected_bag = -1
	bank_selected_vault = -1
	save_slots()
	queue_redraw()

func bank_items() -> Array:
	return slots[active_slot]["bank_items"]

func bank_cell_is_clear(page: int, x: int, y: int, w: int, h: int) -> bool:
	if x < 0 or y < 0 or x + w > BAG_COLS or y + h > BAG_ROWS:
		return false
	for placed_variant in bank_items():
		var placed: Dictionary = placed_variant
		if int(placed.get("page", 0)) != page:
			continue
		var definition: Dictionary = ITEM_DATA.get(str(placed.get("id", "")), {})
		if definition.is_empty():
			continue
		var px: int = int(placed["x"])
		var py: int = int(placed["y"])
		var pw: int = int(definition["w"])
		var ph: int = int(definition["h"])
		if x < px + pw and x + w > px and y < py + ph and y + h > py:
			return false
	return true

func find_bank_space(item_id: String) -> Vector3i:
	if not ITEM_DATA.has(item_id):
		return Vector3i(-1, -1, -1)
	var definition: Dictionary = ITEM_DATA[item_id]
	for page in range(BANK_PAGES):
		for y in range(BAG_ROWS):
			for x in range(BAG_COLS):
				if bank_cell_is_clear(page, x, y, int(definition["w"]), int(definition["h"])):
					return Vector3i(page, x, y)
	return Vector3i(-1, -1, -1)

func bank_item_at_cell(page: int, x: int, y: int) -> int:
	var vault: Array = bank_items()
	for i in range(vault.size()):
		var entry: Dictionary = vault[i]
		if int(entry.get("page", 0)) != page:
			continue
		var def: Dictionary = ITEM_DATA.get(str(entry["id"]), {})
		if def.is_empty():
			continue
		if x >= int(entry["x"]) and x < int(entry["x"]) + int(def["w"]) and y >= int(entry["y"]) and y < int(entry["y"]) + int(def["h"]):
			return i
	return -1

func bank_deposit_item() -> void:
	var bag: Array = bag_items()
	if bank_selected_bag < 0 or bank_selected_bag >= bag.size():
		return
	var selected: Dictionary = bag[bank_selected_bag]
	var item_id: String = str(selected["id"])
	var quantity: int = stack_count(selected) if is_elixer(item_id) else 1
	var vault: Array = bank_items()
	if is_elixer(item_id):
		var available: int = 0
		for item_variant in vault:
			var existing: Dictionary = item_variant
			if str(existing["id"]) == item_id:
				available += maxi(0, ELIXER_STACK_MAX - stack_count(existing))
		for page in range(BANK_PAGES):
			for y in range(BAG_ROWS):
				for x in range(BAG_COLS):
					if bank_cell_is_clear(page, x, y, 1, 1):
						available += ELIXER_STACK_MAX
		if available < quantity:
			status_message = "Bank vault is full"
		else:
			var remaining: int = quantity
			for i in range(vault.size()):
				var existing: Dictionary = vault[i]
				if str(existing["id"]) != item_id:
					continue
				var add_count: int = mini(remaining, ELIXER_STACK_MAX - stack_count(existing))
				if add_count > 0:
					existing["count"] = stack_count(existing) + add_count
					vault[i] = existing
					remaining -= add_count
				if remaining <= 0:
					break
			while remaining > 0:
				var location: Vector3i = find_bank_space(item_id)
				if location.x < 0:
					break
				var to_add: int = mini(remaining, ELIXER_STACK_MAX)
				vault.append({"id": item_id, "page": location.x, "x": location.y, "y": location.z, "count": to_add})
				bank_page = location.x
				remaining -= to_add
			bag.remove_at(bank_selected_bag)
			status_message = "Stored %d x %s" % [quantity, str(ITEM_DATA[item_id]["name"])]
	else:
		var location: Vector3i = find_bank_space(item_id)
		if location.x < 0:
			status_message = "Bank vault is full"
		else:
			vault.append({"id": item_id, "page": location.x, "x": location.y, "y": location.z})
			bag.remove_at(bank_selected_bag)
			bank_page = location.x
			status_message = "Stored " + str(ITEM_DATA[item_id]["name"])
	bank_selected_bag = -1
	bank_selected_vault = -1
	status_timer = 2.0
	save_slots()

func bank_withdraw_item() -> void:
	var vault: Array = bank_items()
	if bank_selected_vault < 0 or bank_selected_vault >= vault.size():
		return
	var item_id: String = str(vault[bank_selected_vault]["id"])
	var quantity: int = stack_count(vault[bank_selected_vault]) if is_elixer(item_id) else 1
	if add_item_to_bag(item_id, quantity):
		vault.remove_at(bank_selected_vault)
		status_message = "Withdrew " + str(ITEM_DATA[item_id]["name"])
	else:
		status_message = "Backpack is full"
	bank_selected_bag = -1
	bank_selected_vault = -1
	status_timer = 2.0
	save_slots()

func handle_bank_tap(pos: Vector2) -> void:
	if BANK_CLOSE_BUTTON.has_point(pos):
		close_bank()
		return
	if BANK_GOLD_DEPOSIT_BUTTON.has_point(pos):
		var amount: int = maxi(0, int(slots[active_slot]["gold"]))
		slots[active_slot]["bank_gold"] = int(slots[active_slot]["bank_gold"]) + amount
		slots[active_slot]["gold"] = 0
		status_message = "Deposited %d gold" % amount
	elif BANK_GOLD_WITHDRAW_BUTTON.has_point(pos):
		var amount: int = maxi(0, int(slots[active_slot]["bank_gold"]))
		slots[active_slot]["gold"] = int(slots[active_slot]["gold"]) + amount
		slots[active_slot]["bank_gold"] = 0
		status_message = "Withdrew %d gold" % amount
	elif BANK_PREV_BUTTON.has_point(pos):
		bank_page = maxi(0, bank_page - 1)
		bank_selected_vault = -1
	elif BANK_NEXT_BUTTON.has_point(pos):
		bank_page = mini(BANK_PAGES - 1, bank_page + 1)
		bank_selected_vault = -1
	elif BANK_DEPOSIT_BUTTON.has_point(pos):
		bank_deposit_item()
	elif BANK_WITHDRAW_BUTTON.has_point(pos):
		bank_withdraw_item()
	else:
		var pitch: float = BANK_GRID_CELL + BANK_GRID_GAP
		var bag_local: Vector2 = pos - BANK_BAG_ORIGIN
		var bx: int = int(floor(bag_local.x / pitch))
		var by: int = int(floor(bag_local.y / pitch))
		if bx >= 0 and bx < BAG_COLS and by >= 0 and by < BAG_ROWS:
			bank_selected_bag = item_at_cell(bx, by)
			bank_selected_vault = -1
		else:
			var bank_local: Vector2 = pos - BANK_VAULT_ORIGIN
			var vx: int = int(floor(bank_local.x / pitch))
			var vy: int = int(floor(bank_local.y / pitch))
			if vx >= 0 and vx < BAG_COLS and vy >= 0 and vy < BAG_ROWS:
				bank_selected_vault = bank_item_at_cell(bank_page, vx, vy)
				bank_selected_bag = -1
	status_timer = 2.0
	save_slots()
	queue_redraw()

func draw_bank() -> void:
	draw_rect(Rect2(42, 58, 877, 440), Color("101a27"))
	draw_rect(Rect2(42, 58, 877, 440), Color("d1bc81"), false, 3.0)
	draw_label("BANKER - SECURE VAULT", Vector2(69, 93), 23, Color("f1dfac"))
	draw_label("CARRIED BACKPACK", Vector2(89, 139), 18, Color("d6dfef"))
	draw_label("VAULT PAGE %d / %d" % [bank_page + 1, BANK_PAGES], Vector2(578, 139), 18, Color("b4e8ba"))
	draw_label("Gold %d" % int(slots[active_slot]["gold"]), Vector2(92, 162), 15, Color("f5db82"))
	draw_label("Bank Gold %d" % int(slots[active_slot]["bank_gold"]), Vector2(579, 162), 15, Color("f5db82"))
	draw_rect(BANK_CLOSE_BUTTON, Color("943d43"))
	draw_label("X", BANK_CLOSE_BUTTON.position + Vector2(23, 33), 26)
	var pitch: float = BANK_GRID_CELL + BANK_GRID_GAP
	for y in range(BAG_ROWS):
		for x in range(BAG_COLS):
			var offset: Vector2 = Vector2(x, y) * pitch
			var bag_cell: Rect2 = Rect2(BANK_BAG_ORIGIN + offset, Vector2(BANK_GRID_CELL, BANK_GRID_CELL))
			var bank_cell: Rect2 = Rect2(BANK_VAULT_ORIGIN + offset, Vector2(BANK_GRID_CELL, BANK_GRID_CELL))
			draw_rect(bag_cell, Color("293347"))
			draw_rect(bag_cell, Color("566278"), false, 1.0)
			draw_rect(bank_cell, Color("283c36"))
			draw_rect(bank_cell, Color("597464"), false, 1.0)
	for i in range(bag_items().size()):
		var item: Dictionary = bag_items()[i]
		var item_id: String = str(item["id"])
		var def: Dictionary = ITEM_DATA.get(item_id, {})
		if def.is_empty():
			continue
		var pos: Vector2 = BANK_BAG_ORIGIN + Vector2(int(item["x"]), int(item["y"])) * pitch
		var size: Vector2 = Vector2(float(int(def["w"])) * pitch - BANK_GRID_GAP, float(int(def["h"])) * pitch - BANK_GRID_GAP)
		draw_rect(Rect2(pos, size), Color(str(def["color"])))
		draw_rect(Rect2(pos, size), Color("ffdc8a") if i == bank_selected_bag else item_border_color(item_id), false, 3.0)
		draw_item_icon(item_id, pos + size * 0.5, inventory_icon_scale(item_id, size, 0.58))
		if is_elixer(item_id):
			draw_label("%d" % stack_count(item), pos + Vector2(size.x - 18.0, size.y - 4.0), 12, Color("ffffff"))
	for i in range(bank_items().size()):
		var item: Dictionary = bank_items()[i]
		if int(item.get("page", 0)) != bank_page:
			continue
		var item_id: String = str(item["id"])
		var def: Dictionary = ITEM_DATA.get(item_id, {})
		if def.is_empty():
			continue
		var pos: Vector2 = BANK_VAULT_ORIGIN + Vector2(int(item["x"]), int(item["y"])) * pitch
		var size: Vector2 = Vector2(float(int(def["w"])) * pitch - BANK_GRID_GAP, float(int(def["h"])) * pitch - BANK_GRID_GAP)
		draw_rect(Rect2(pos, size), Color(str(def["color"])))
		draw_rect(Rect2(pos, size), Color("ffdc8a") if i == bank_selected_vault else item_border_color(item_id), false, 3.0)
		draw_item_icon(item_id, pos + size * 0.5, inventory_icon_scale(item_id, size, 0.58))
		if is_elixer(item_id):
			draw_label("%d" % stack_count(item), pos + Vector2(size.x - 18.0, size.y - 4.0), 12, Color("ffffff"))
	for r in [BANK_DEPOSIT_BUTTON, BANK_WITHDRAW_BUTTON, BANK_PREV_BUTTON, BANK_NEXT_BUTTON, BANK_GOLD_DEPOSIT_BUTTON, BANK_GOLD_WITHDRAW_BUTTON]:
		draw_rect(r, Color("34566c"))
		draw_rect(r, Color("a9c8c6"), false, 2.0)
	draw_label("DEPOSIT", BANK_DEPOSIT_BUTTON.position + Vector2(14, 31), 18)
	draw_label("WITHDRAW", BANK_WITHDRAW_BUTTON.position + Vector2(7, 31), 17)
	draw_label("PREV", BANK_PREV_BUTTON.position + Vector2(12, 26), 16)
	draw_label("NEXT", BANK_NEXT_BUTTON.position + Vector2(13, 26), 16)
	draw_label("DEPOSIT ALL GOLD", BANK_GOLD_DEPOSIT_BUTTON.position + Vector2(11, 25), 15)
	draw_label("WITHDRAW ALL GOLD", BANK_GOLD_WITHDRAW_BUTTON.position + Vector2(12, 25), 15)
	var label_text: String = "Select backpack item to deposit or vault item to withdraw"
	if bank_selected_bag >= 0 and bank_selected_bag < bag_items().size():
		label_text = "Deposit: " + str(ITEM_DATA[str(bag_items()[bank_selected_bag]["id"])]["name"])
	elif bank_selected_vault >= 0 and bank_selected_vault < bank_items().size():
		label_text = "Withdraw: " + str(ITEM_DATA[str(bank_items()[bank_selected_vault]["id"])]["name"])
	draw_label(label_text, Vector2(89, 424), 14, Color("e1e9ea"))

func draw_bag_icon(center: Vector2, scale_value: float = 1.0) -> void:
	draw_set_transform(center, 0.0, Vector2(scale_value, scale_value))
	# Leather backpack with straps, flap and brass clasp.
	draw_rect(Rect2(-16, -8, 32, 28), Color("67452f"))
	draw_rect(Rect2(-12, -13, 24, 32), Color("be8951"))
	draw_rect(Rect2(-10, -17, 20, 9), Color("8d603a"))
	draw_line(Vector2(-7, -14), Vector2(-7, 17), Color("e7bc78"), 3.0)
	draw_line(Vector2(7, -14), Vector2(7, 17), Color("e7bc78"), 3.0)
	draw_rect(Rect2(-4, -2, 8, 8), Color("f6d28b"))
	draw_rect(Rect2(-12, 11, 24, 8), Color("91633e"))
	draw_set_transform(Vector2.ZERO)

func draw_portal_icon(center: Vector2, scale_value: float = 1.0) -> void:
	draw_set_transform(center, 0.0, Vector2(scale_value, scale_value))
	draw_arc(Vector2.ZERO, 14.0, 0.0, TAU, 32, Color("7bd3ff"), 4.0)
	draw_arc(Vector2.ZERO, 8.0, 0.5, TAU + 0.5, 28, Color("d8f4ff"), 3.0)
	draw_polyline(PackedVector2Array([Vector2(-5, -10), Vector2(2, -4), Vector2(-1, 2), Vector2(6, 9)]), Color("ffffff"), 2.0, false)
	draw_circle(Vector2(-12, -8), 2.0, Color("aef0ff"))
	draw_circle(Vector2(12, 7), 2.0, Color("aef0ff"))
	draw_set_transform(Vector2.ZERO)

func draw_stats_icon(center: Vector2, scale_value: float = 1.0) -> void:
	draw_set_transform(center, 0.0, Vector2(scale_value, scale_value))
	draw_rect(Rect2(-18, -18, 36, 36), Color("78302e"))
	draw_rect(Rect2(-18, -18, 36, 36), Color("31110f"), false, 2.0)
	draw_line(Vector2(-12, 11), Vector2(-12, -11), Color.BLACK, 3.0)
	draw_line(Vector2(-12, 11), Vector2(12, 11), Color.BLACK, 3.0)
	draw_rect(Rect2(-8, -1, 6, 12), Color("dc6a6e"))
	draw_rect(Rect2(-8, -1, 6, 12), Color("000000"), false, 1.5)
	draw_rect(Rect2(1, -10, 6, 21), Color("66c76b"))
	draw_rect(Rect2(1, -10, 6, 21), Color("000000"), false, 1.5)
	draw_rect(Rect2(10, 4, 6, 7), Color("718cf0"))
	draw_rect(Rect2(10, 4, 6, 7), Color("000000"), false, 1.5)
	draw_set_transform(Vector2.ZERO)

func draw_shield_symbol(center: Vector2, scale_value: float = 1.0, shield_fill: Color = Color("b8cadb"), shield_trim: Color = Color("eef7ff")) -> void:
	draw_set_transform(center, 0.0, Vector2(scale_value, scale_value))
	draw_colored_polygon(PackedVector2Array([Vector2(-10, -13), Vector2(10, -13), Vector2(10, 3), Vector2(0, 14), Vector2(-10, 3)]), shield_fill)
	draw_polyline(PackedVector2Array([Vector2(-10, -13), Vector2(10, -13), Vector2(10, 3), Vector2(0, 14), Vector2(-10, 3), Vector2(-10, -13)]), shield_trim, 2.2)
	draw_rect(Rect2(-2, -9, 4, 17), shield_trim)
	draw_rect(Rect2(-6, -1, 12, 3), shield_trim)
	draw_set_transform(Vector2.ZERO)

func draw_knight_ability_icon(center: Vector2, scale_value: float = 1.0, energized: bool = false) -> void:
	var ring_color: Color = Color("98ecff") if energized else Color("c8d4de")
	draw_arc(center, 15.0 * scale_value, 0.0, TAU, 28, ring_color, 2.0)
	var orbit := 12.0 * scale_value
	for i in range(3):
		var angle: float = TAU * float(i) / 3.0 - PI * 0.5
		var shield_center: Vector2 = center + Vector2.RIGHT.rotated(angle) * orbit
		draw_shield_symbol(shield_center, 0.55 * scale_value, Color("86a7c3") if energized else Color("85909b"), Color("eef9ff") if energized else Color("dbe2e8"))

func draw_ground_item_icon(item_id: String, center: Vector2) -> void:
	# Detailed, borderless ground equipment. Every gear silhouette is drawn in
	# white (T1) or green (T2), with darker joints and lighter metallic accents.
	# No enclosing square or loot box is used.
	var base: String = item_base_id(item_id)
	if base == "bloody_footprints":
		draw_item_icon("bloody_footprints", center, 0.92)
		return
	var main: Color = item_border_color(item_id)
	var shine: Color = main.lightened(0.20)
	var shadow: Color = main.darkened(0.60)
	var mid: Color = main.darkened(0.23)
	draw_set_transform(center, 0.0)
	if base.ends_with("sword") or base == "rogue_dagger" or base == "rogue_offhand_dagger" or base == "throwing_knife":
		# Diamond-edged blade, fuller, ricasso, guard, wrapped grip, pommel.
		var short_blade: bool = base == "rogue_dagger" or base == "rogue_offhand_dagger" or base == "throwing_knife"
		var tip_y: float = -21.0 if short_blade else (-61.0 if is_two_handed_weapon(item_id) else -45.0)
		var shoulder_y: float = tip_y + (9.0 if short_blade else (18.0 if is_two_handed_weapon(item_id) else 13.0))
		# True longsword silhouette: long parallel bevels, narrow ricasso and a
		# pronounced point. Knives retain a clearly shorter blade.
		draw_colored_polygon(PackedVector2Array([Vector2(-5, -7), Vector2(-6, shoulder_y), Vector2(0, tip_y), Vector2(6, shoulder_y), Vector2(5, -7)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-3, -7), Vector2(-5, shoulder_y), Vector2(0, tip_y + 2), Vector2(0, -7)]), shine)
		draw_colored_polygon(PackedVector2Array([Vector2(0, tip_y + 2), Vector2(5, shoulder_y), Vector2(3, -7), Vector2(0, -7)]), main)
		draw_line(Vector2(0, tip_y + 7), Vector2(0, -8), mid, 1.5)
		draw_colored_polygon(PackedVector2Array([Vector2(-14, -5), Vector2(-9, -9), Vector2(0, -5), Vector2(9, -9), Vector2(14, -5), Vector2(11, -1), Vector2(-11, -1)]), mid)
		draw_line(Vector2(-10, -5), Vector2(10, -5), shine, 2.0)
		draw_rect(Rect2(-3, -1, 6, 18), shadow)
		for yy in [3.0, 8.0, 13.0]:
			draw_line(Vector2(-3, yy), Vector2(3, yy - 2), shine, 1.2)
		draw_circle(Vector2(0, 20), 4.5, main)
		draw_circle(Vector2(0, 20), 2.0, shine)
		if base == "god_sword":
			draw_polyline(PackedVector2Array([Vector2(12, -37), Vector2(7, -28), Vector2(13, -19), Vector2(7, -7)]), Color("b5eaff"), 2.0)
	elif base.ends_with("shield"):
		# Riveted shield with a raised central boss and cross reinforcement.
		draw_colored_polygon(PackedVector2Array([Vector2(-19, -21), Vector2(19, -21), Vector2(18, 5), Vector2(12, 15), Vector2(0, 26), Vector2(-12, 15), Vector2(-18, 5)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-16, -18), Vector2(16, -18), Vector2(15, 4), Vector2(0, 22), Vector2(-15, 4)]), main)
		draw_colored_polygon(PackedVector2Array([Vector2(-13, -16), Vector2(0, -16), Vector2(0, 18), Vector2(-12, 3)]), mid)
		draw_line(Vector2(-14, -17), Vector2(14, -17), shine, 2.0)
		draw_rect(Rect2(-2, -13, 4, 27), shine)
		draw_rect(Rect2(-11, -3, 22, 5), shine)
		draw_circle(Vector2(0, -2), 4, shadow)
		draw_circle(Vector2(0, -2), 2, shine)
		for rivet in [Vector2(-12, -13), Vector2(12, -13), Vector2(-11, 7), Vector2(11, 7)]:
			draw_circle(rivet, 1.8, shine)
	elif base.ends_with("helm") or base.ends_with("cap") or base == "cloth_hood":
		# Helmet with brow band, dark visor, cheek guards and crest.
		draw_colored_polygon(PackedVector2Array([Vector2(-18, 14), Vector2(-19, -3), Vector2(-13, -17), Vector2(-5, -23), Vector2(5, -23), Vector2(13, -17), Vector2(19, -3), Vector2(18, 14), Vector2(10, 19), Vector2(-10, 19)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-15, 11), Vector2(-15, -4), Vector2(-10, -15), Vector2(0, -20), Vector2(10, -15), Vector2(15, -4), Vector2(15, 11)]), main)
		draw_colored_polygon(PackedVector2Array([Vector2(-14, -1), Vector2(0, -6), Vector2(0, -18), Vector2(-9, -13)]), shine)
		draw_rect(Rect2(-14, -2, 28, 8), shadow)
		draw_rect(Rect2(-12, 0, 9, 3), Color("161d20"))
		draw_rect(Rect2(3, 0, 9, 3), Color("161d20"))
		draw_rect(Rect2(-2, -5, 4, 15), mid)
		draw_line(Vector2(-16, 11), Vector2(-10, 15), shine, 2.0)
		draw_line(Vector2(16, 11), Vector2(10, 15), shine, 2.0)
		if base == "plate_helm":
			draw_colored_polygon(PackedVector2Array([Vector2(-3, -18), Vector2(-2, -29), Vector2(2, -31), Vector2(5, -18)]), shine)
	elif base.ends_with("armor") or base.ends_with("robe") or base == "plate_chest" or base == "leather_vest":
		# Defined breastplate: shoulder pauldrons, narrow torso, split hem,
		# embossed breast panel and belt. No rounded mushroom silhouette.
		draw_colored_polygon(PackedVector2Array([Vector2(-15, -21), Vector2(-25, -13), Vector2(-27, -3), Vector2(-19, 6), Vector2(-13, 3), Vector2(-12, 22), Vector2(12, 22), Vector2(13, 3), Vector2(19, 6), Vector2(27, -3), Vector2(25, -13), Vector2(15, -21)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-12, -18), Vector2(-8, -22), Vector2(8, -22), Vector2(12, -18), Vector2(11, 9), Vector2(7, 20), Vector2(-7, 20), Vector2(-11, 9)]), main)
		draw_colored_polygon(PackedVector2Array([Vector2(-16, -17), Vector2(-23, -10), Vector2(-24, -2), Vector2(-16, 2), Vector2(-12, -8)]), mid)
		draw_colored_polygon(PackedVector2Array([Vector2(16, -17), Vector2(23, -10), Vector2(24, -2), Vector2(16, 2), Vector2(12, -8)]), mid)
		draw_line(Vector2(-22, -9), Vector2(-16, -13), shine, 2.0)
		draw_line(Vector2(22, -9), Vector2(16, -13), shine, 2.0)
		draw_colored_polygon(PackedVector2Array([Vector2(-8, -16), Vector2(0, -12), Vector2(8, -16), Vector2(7, 3), Vector2(0, 9), Vector2(-7, 3)]), shine)
		draw_line(Vector2(0, -13), Vector2(0, 10), mid, 2.0)
		draw_rect(Rect2(-12, 8, 24, 5), shadow)
		draw_rect(Rect2(-2, 8, 4, 5), shine)
		draw_line(Vector2(-10, 17), Vector2(-2, 21), mid, 2.0)
		draw_line(Vector2(10, 17), Vector2(2, 21), mid, 2.0)
	elif base.ends_with("legs") or base.ends_with("pants") or base == "leather_leggings":
		# Belt, separated greaves, overlapping knee plates, reinforced toes.
		draw_colored_polygon(PackedVector2Array([Vector2(-15, -22), Vector2(15, -22), Vector2(12, 22), Vector2(4, 22), Vector2(0, -2), Vector2(-4, 22), Vector2(-12, 22)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-12, -17), Vector2(-2, -17), Vector2(-4, 18), Vector2(-11, 18)]), main)
		draw_colored_polygon(PackedVector2Array([Vector2(2, -17), Vector2(12, -17), Vector2(11, 18), Vector2(4, 18)]), main)
		draw_rect(Rect2(-15, -21, 30, 6), mid)
		draw_rect(Rect2(-3, -22, 6, 8), shine)
		for side in [-1.0, 1.0]:
			draw_line(Vector2(side * 4, -7), Vector2(side * 12, -7), shine, 2.0)
			draw_line(Vector2(side * 4, 7), Vector2(side * 12, 7), shine, 2.0)
			draw_line(Vector2(side * 4, 20), Vector2(side * 12, 20), shine, 2.5)
	elif base == "short_bow":
		# Curved stave, illuminated notches and visible bowstring.
		draw_arc(Vector2(-5, 0), 24.0, -PI * 0.5, PI * 0.5, 24, shadow, 7.0)
		draw_arc(Vector2(-5, 0), 24.0, -PI * 0.5, PI * 0.5, 24, main, 4.0)
		draw_line(Vector2(-5, -24), Vector2(-5, 24), shine, 1.7)
		draw_line(Vector2(1, -3), Vector2(11, 0), mid, 3.0)
		draw_circle(Vector2(-5, -24), 2.0, shine)
		draw_circle(Vector2(-5, 24), 2.0, shine)
	elif base == "quiver":
		# Arrow tips, feather fletching and tapering leather holder.
		for xx in [-8.0, 0.0, 8.0]:
			draw_line(Vector2(xx, -24), Vector2(xx, 6), mid, 2.0)
			draw_colored_polygon(PackedVector2Array([Vector2(xx - 3, -19), Vector2(xx, -27), Vector2(xx + 3, -19)]), shine)
		draw_colored_polygon(PackedVector2Array([Vector2(-14, -8), Vector2(14, -8), Vector2(10, 22), Vector2(-10, 22)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-11, -6), Vector2(11, -6), Vector2(8, 19), Vector2(-8, 19)]), main)
		draw_line(Vector2(-10, 3), Vector2(10, 3), shine, 2.0)
		draw_line(Vector2(-8, 13), Vector2(8, 13), mid, 2.0)
	elif base == "spellbook" or base == "holy_book":
		# Open book with page edges, spine and magic insignia.
		draw_colored_polygon(PackedVector2Array([Vector2(-22, -19), Vector2(-2, -16), Vector2(0, -12), Vector2(2, -16), Vector2(22, -19), Vector2(22, 18), Vector2(0, 22), Vector2(-22, 18)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-19, -16), Vector2(-3, -13), Vector2(-2, 17), Vector2(-19, 15)]), main)
		draw_colored_polygon(PackedVector2Array([Vector2(3, -13), Vector2(19, -16), Vector2(19, 15), Vector2(2, 17)]), shine)
		draw_line(Vector2(0, -17), Vector2(0, 20), mid, 2.0)
		draw_circle(Vector2(10, 1), 5, mid)
		draw_circle(Vector2(10, 1), 2, main)
		for yy in [-8.0, 10.0]:
			draw_line(Vector2(-16, yy), Vector2(-6, yy + 2), shine, 1.5)
	elif base == "apprentice_wand" or base == "priest_staff" or base == "sorcerer_staff" or base == "cleric_sceptre":
		# Wrapped magical staff with crystal setting.
		draw_line(Vector2(-13, 23), Vector2(10, -21), shadow, 7.0)
		draw_line(Vector2(-13, 23), Vector2(10, -21), main, 4.0)
		for i in range(4):
			var off: float = float(i) * 5.0
			draw_line(Vector2(-11 + off * 0.45, 18 - off), Vector2(-5 + off * 0.45, 21 - off), shine, 1.5)
		draw_colored_polygon(PackedVector2Array([Vector2(10, -34), Vector2(18, -25), Vector2(10, -17), Vector2(2, -25)]), mid)
		draw_colored_polygon(PackedVector2Array([Vector2(10, -31), Vector2(15, -25), Vector2(10, -21), Vector2(5, -25)]), shine)
	elif base == "cleric_mace":
		# Heavy blunt mace: thick shaft and broad metal flanged head.
		draw_line(Vector2(-6, 24), Vector2(5, -16), shadow, 9.0)
		draw_line(Vector2(-6, 24), Vector2(5, -16), main, 5.0)
		draw_colored_polygon(PackedVector2Array([Vector2(-11, -31), Vector2(9, -36), Vector2(17, -24), Vector2(8, -13), Vector2(-10, -19)]), shadow)
		draw_colored_polygon(PackedVector2Array([Vector2(-7, -29), Vector2(7, -32), Vector2(12, -24), Vector2(5, -17), Vector2(-7, -21)]), shine)
	elif base == "holy_relic":
		# Embossed sun relic and cross with gem center.
		for i in range(8):
			var angle: float = TAU * float(i) / 8.0
			draw_line(Vector2.RIGHT.rotated(angle) * 17.0, Vector2.RIGHT.rotated(angle) * 24.0, main, 3.0)
		draw_circle(Vector2.ZERO, 17, shadow)
		draw_circle(Vector2.ZERO, 14, main)
		draw_rect(Rect2(-3, -12, 6, 24), shine)
		draw_rect(Rect2(-10, -4, 20, 6), shine)
		draw_circle(Vector2.ZERO, 3, mid)
	else:
		# Future equipment uses the standard model until assigned a ground icon.
		draw_set_transform(Vector2.ZERO)
		draw_item_icon(item_id, center, 0.85)
		return
	draw_set_transform(Vector2.ZERO)

func draw_bat_wings(center: Vector2, scale_value: float = 1.0, large: bool = true, facing_rotation: float = 0.0) -> void:
	# Layered jagged bat wings, attached behind the character's shoulders.
	# The wing membranes and prominent bone fingers are visible around the body.
	draw_set_transform(center, facing_rotation, Vector2(scale_value, scale_value))
	var flap: float = sin(lightning_clock * 4.2) * (5.0 if large else 0.0)
	var dark: Color = Color("170e24")
	var membrane: Color = Color("54245f")
	var ridge: Color = Color("9c5ab8")
	for side in [-1.0, 1.0]:
		var root: Vector2 = Vector2(side * 5, -10)
		var shoulder: Vector2 = Vector2(side * 29, -27 + flap * 0.2)
		var tip: Vector2 = Vector2(side * 73, -54 + flap)
		var finger: Vector2 = Vector2(side * 87, -4 + flap)
		var claw_a: Vector2 = Vector2(side * 60, 21 + flap * 0.4)
		var claw_b: Vector2 = Vector2(side * 39, 15 + flap * 0.2)
		draw_colored_polygon(PackedVector2Array([root, shoulder, tip, finger, claw_a, claw_b, Vector2(side * 13, 14)]), dark)
		draw_colored_polygon(PackedVector2Array([root, shoulder + Vector2(0, 3), tip + Vector2(-side * 5, 7), finger + Vector2(-side * 8, -5), claw_a + Vector2(-side * 4, -7), claw_b + Vector2(-side * 2, -6), Vector2(side * 12, 8)]), membrane)
		for joint in [shoulder, tip, finger, claw_a, claw_b]:
			draw_line(root, joint, ridge, 2.0 if joint == shoulder else 1.5)
		for rib in range(3):
			var x: float = side * (29.0 + float(rib) * 15.0)
			draw_line(Vector2(x, -16 + flap * 0.2), Vector2(x + side * 10.0, 5 + flap * 0.3), Color("311637"), 2.0)
	draw_set_transform(Vector2.ZERO)

func draw_worn_bat_wings(center: Vector2) -> void:
	# TOP-DOWN CHARACTER PROJECTION: wings are upright on the BACK, never
	# rotated flat across the floor. Their roots stay at the upper torso.
	# The silhouette changes with facing as a cloak/back accessory would.
	var facing_up: bool = facing_direction.y < -0.45 and absf(facing_direction.y) >= absf(facing_direction.x)
	var facing_down: bool = facing_direction.y > 0.45 and absf(facing_direction.y) >= absf(facing_direction.x)
	var facing_side: bool = not facing_up and not facing_down
	var flap: float = sin(lightning_clock * 4.2) * 4.5
	var reach: float = 64.0 if facing_up else (49.0 if facing_down else 43.0)
	var height: float = 68.0 if facing_up else (53.0 if facing_down else 58.0)
	var root_y: float = -9.0
	var near_side: float = 1.0 if facing_direction.x >= 0.0 else -1.0
	var dark: Color = Color("130d1f")
	var membrane: Color = Color("4c245d")
	var membrane_light: Color = Color("793a86")
	var bone: Color = Color("ae75bc")
	for side in [-1.0, 1.0]:
		# In profile, the far wing is nearly edge-on, like a real back accessory.
		var side_reach: float = reach
		if facing_side:
			side_reach *= 0.43 if side != near_side else 1.1
		var root: Vector2 = center + Vector2(side * 8.0, root_y)
		var elbow: Vector2 = center + Vector2(side * (side_reach * 0.42), -height * 0.63)
		var upper: Vector2 = center + Vector2(side * side_reach, -height + flap)
		var outer: Vector2 = center + Vector2(side * (side_reach + 6.0), -height * 0.38 + flap * 0.7)
		var scallop_a: Vector2 = center + Vector2(side * (side_reach * 0.77), -height * 0.43 + flap * 0.5)
		var scallop_b: Vector2 = center + Vector2(side * (side_reach * 0.60), -height * 0.12 + flap * 0.2)
		var inner: Vector2 = center + Vector2(side * 18.0, 1.0)
		var outline: PackedVector2Array = PackedVector2Array([root, elbow, upper, outer, scallop_a, scallop_b, inner])
		draw_colored_polygon(outline, dark)
		draw_colored_polygon(PackedVector2Array([root, elbow + Vector2(0, 3), upper + Vector2(-side * 4, 5), outer + Vector2(-side * 6, -4), scallop_a + Vector2(-side * 2, -4), scallop_b, inner]), membrane)
		draw_colored_polygon(PackedVector2Array([root, elbow, upper + Vector2(-side * 4, 5), elbow + Vector2(-side * 3, 9)]), membrane_light)
		draw_line(root, elbow, bone, 2.6)
		draw_line(elbow, upper, bone, 2.1)
		draw_line(root, outer, Color("8e55a4"), 1.6)
		draw_line(root, scallop_b, Color("78408c"), 1.6)
		# A tiny upward claw at each top wing tip reinforces the vertical shape.
		draw_line(upper, upper + Vector2(side * 3, -7), Color("c4a4d3"), 1.8)
	# Center harness belongs to the back of the chest, not the ground plane.
	draw_circle(center + Vector2(0, -10), 5.5, Color("2d1838"))
	draw_circle(center + Vector2(0, -10), 2.0, Color("ba81c9"))

func draw_bloody_boots_icon(center: Vector2, pixel_scale: float = 1.0) -> void:
	draw_set_transform(center, 0.0, Vector2(pixel_scale, pixel_scale))
	var leather := Color("6b2228")
	var trim := Color("ba474c")
	var sole := Color("321216")
	for side in [-1.0, 1.0]:
		var x: float = side * 10.0
		draw_colored_polygon(PackedVector2Array([Vector2(x - 7, -12), Vector2(x + 3, -12), Vector2(x + 5, -1), Vector2(x + 9, 5), Vector2(x + 5, 11), Vector2(x - 8, 11), Vector2(x - 10, -2)]), leather)
		draw_polyline(PackedVector2Array([Vector2(x - 7, -12), Vector2(x + 3, -12), Vector2(x + 5, -1), Vector2(x + 9, 5), Vector2(x + 5, 11), Vector2(x - 8, 11), Vector2(x - 10, -2), Vector2(x - 7, -12)]), trim, 2.0)
		draw_line(Vector2(x - 6, -6), Vector2(x + 1, -6), trim, 1.6)
		draw_rect(Rect2(x - 9, 8, 16, 4), sole)
		draw_circle(Vector2(x + 5, 10), 2.2, Color("8f191f"))
		draw_circle(Vector2(x + 8, 7), 1.8, Color("a31a1e"))
	draw_set_transform(Vector2.ZERO)

func inventory_icon_scale(item_id: String, cell_size: Vector2, desired: float) -> float:
	# Most sword art spans ~[-57, +23] vertically before scaling; God Sword
	# ~[-48, +24]. Clamp to the actual visible cell so nothing overflows.
	var max_icon_height: float = 48.0
	if item_base_id(item_id) == "god_sword":
		max_icon_height = 76.0
	elif is_two_handed_weapon(item_id):
		max_icon_height = 84.0
	elif item_base_id(item_id).ends_with("sword"):
		max_icon_height = 67.0
	return minf(desired, minf((cell_size.y - 8.0) / max_icon_height, (cell_size.x - 6.0) / 46.0))

func draw_item_icon(item_id: String, center: Vector2, pixel_scale: float = 1.0) -> void:
	# Icons are drawn as tiny pixel-art items rather than two-letter abbreviations.
	draw_set_transform(center, 0.0, Vector2(pixel_scale, pixel_scale))
	var steel := Color("cbd9e4")
	var dark := Color("28384a")
	var gold := Color("f9de83")
	var brown := Color("98613b")
	var id := item_base_id(item_id)
	if is_elixer(id):
		var fill: Color = Color(str(ITEM_DATA[id]["color"]))
		draw_rect(Rect2(-5, -22, 10, 7), Color("bfc9d7"))
		draw_rect(Rect2(-8, -15, 16, 3), Color("edf6ff"))
		draw_colored_polygon(PackedVector2Array([Vector2(-8, -12), Vector2(8, -12), Vector2(14, 7), Vector2(8, 18), Vector2(-8, 18), Vector2(-14, 7)]), Color("283147"))
		draw_colored_polygon(PackedVector2Array([Vector2(-8, -8), Vector2(8, -8), Vector2(12, 7), Vector2(7, 15), Vector2(-7, 15), Vector2(-12, 7)]), fill)
		draw_line(Vector2(-5, -4), Vector2(-8, 6), Color("ffffff", 0.70), 3.0)
		draw_circle(Vector2(5, 7), 3.0, Color("ffffff", 0.40))
		draw_set_transform(Vector2.ZERO)
		return
	if id == "bloody_footprints":
		draw_set_transform(Vector2.ZERO)
		draw_bloody_boots_icon(center, pixel_scale * 0.78)
		return
	if id == "god_sword":
		# Special icon based on the user's lightning-sword reference.
		draw_colored_polygon(PackedVector2Array([
			Vector2(-2, 20), Vector2(-3, 6), Vector2(-7, -6), Vector2(-6, -33),
			Vector2(0, -48), Vector2(6, -33), Vector2(7, -6), Vector2(3, 6), Vector2(2, 20)
		]), Color("dff8ff"))
		draw_polyline(PackedVector2Array([Vector2(-3, 16), Vector2(-5, -6), Vector2(0, -44), Vector2(5, -6), Vector2(3, 16)]), Color("7edfff"), 3.0, false)
		draw_colored_polygon(PackedVector2Array([
			Vector2(-12, 2), Vector2(-4, -2), Vector2(0, -1), Vector2(4, -2), Vector2(12, 2),
			Vector2(7, 6), Vector2(0, 4), Vector2(-7, 6)
		]), Color("18222f"))
		draw_colored_polygon(PackedVector2Array([
			Vector2(-4, 18), Vector2(-2, 4), Vector2(2, 4), Vector2(4, 18), Vector2(0, 24)
		]), Color("1f2c38"))
		draw_polyline(PackedVector2Array([Vector2(10, -24), Vector2(4, -15), Vector2(9, -10), Vector2(2, -2), Vector2(7, 4)]), Color("9ff7ff"), 2.0, false)
		draw_polyline(PackedVector2Array([Vector2(-9, -17), Vector2(-3, -10), Vector2(-6, -2), Vector2(0, 5)]), Color("79d8ff"), 2.0, false)
	elif id.ends_with("sword") or id == "rogue_dagger" or id == "rogue_offhand_dagger" or id == "throwing_knife":
		var is_dagger: bool = id == "rogue_dagger" or id == "rogue_offhand_dagger" or id == "throwing_knife"
		var blade_tip: float = -25.0 if is_dagger else (-57.0 if is_two_handed_weapon(item_id) else -43.0)
		var taper_start: float = -17.0 if is_dagger else (-43.0 if is_two_handed_weapon(item_id) else -33.0)
		# Long parallel blade with a central fuller; crossguard and wrapped grip
		# are intentionally smaller than the blade on swords.
		draw_colored_polygon(PackedVector2Array([Vector2(-4, -7), Vector2(-5, taper_start), Vector2(0, blade_tip), Vector2(5, taper_start), Vector2(4, -7)]), Color("8698a9"))
		draw_colored_polygon(PackedVector2Array([Vector2(-3, -8), Vector2(-4, taper_start), Vector2(0, blade_tip + 2), Vector2(0, -8)]), steel)
		draw_colored_polygon(PackedVector2Array([Vector2(0, blade_tip + 2), Vector2(4, taper_start), Vector2(3, -8), Vector2(0, -8)]), Color("eaf4fa"))
		draw_line(Vector2(0, taper_start + 5), Vector2(0, -8), Color("a5bacc"), 1.4)
		draw_line(Vector2(-11, -5), Vector2(11, -5), gold, 3.2)
		draw_line(Vector2(0, -4), Vector2(0, 17), brown, 4.0)
		for grip_y in [3.0, 8.0, 13.0]:
			draw_line(Vector2(-2, grip_y), Vector2(2, grip_y - 1), Color("e1b67f"), 1.2)
		draw_circle(Vector2(0, 19), 4.0, gold)
	elif id.ends_with("shield"):
		var shield_fill := Color("8ca5b8") if id == "steel_shield" else Color("8b623f")
		var shield_trim := Color("edf5fa") if id == "steel_shield" else Color("deb56c")
		draw_colored_polygon(PackedVector2Array([Vector2(-15, -20), Vector2(15, -20), Vector2(15, 6), Vector2(0, 21), Vector2(-15, 6)]), shield_fill)
		draw_polyline(PackedVector2Array([Vector2(-15, -20), Vector2(15, -20), Vector2(15, 6), Vector2(0, 21), Vector2(-15, 6), Vector2(-15, -20)]), shield_trim, 3.0)
		draw_rect(Rect2(-3, -16, 6, 27), shield_trim)
		draw_rect(Rect2(-10, -4, 20, 4), shield_trim)
	elif id.ends_with("helm") or id.ends_with("cap") or id == "cloth_hood":
		var helm_fill := Color("a6b8cb") if id == "iron_helm" or id == "plate_helm" else Color("9d714b")
		var helm_high := Color("eef4f8") if id == "iron_helm" or id == "plate_helm" else Color("d2a170")
		draw_colored_polygon(PackedVector2Array([Vector2(-16, 9), Vector2(-15, -3), Vector2(-11, -13), Vector2(-4, -19), Vector2(4, -19), Vector2(11, -13), Vector2(15, -3), Vector2(16, 9)]), helm_fill)
		draw_rect(Rect2(-11, -4, 22, 12), Color("18212a"))
		draw_rect(Rect2(-7, -2, 5, 7), helm_high)
		draw_rect(Rect2(2, -2, 5, 7), helm_high)
		draw_rect(Rect2(-4, -5, 8, 15), helm_high)
		if id == "plate_helm":
			draw_line(Vector2(-13, 7), Vector2(13, 7), Color("f7fbff"), 2.0)
			draw_rect(Rect2(-3, -17, 6, 7), Color("73889f"))
	elif id.ends_with("armor") or id.ends_with("robe") or id == "plate_chest" or id == "leather_vest":
		if id == "plate_chest":
			draw_colored_polygon(PackedVector2Array([Vector2(-13, -17), Vector2(-23, -7), Vector2(-17, 7), Vector2(-10, 3), Vector2(-10, 20), Vector2(10, 20), Vector2(10, 3), Vector2(17, 7), Vector2(23, -7), Vector2(13, -17)]), Color("8196a9"))
			draw_colored_polygon(PackedVector2Array([Vector2(-11, -15), Vector2(11, -15), Vector2(10, 8), Vector2(0, 15), Vector2(-10, 8)]), Color("d7e0e9"))
			draw_line(Vector2(-10, -5), Vector2(10, -5), Color("f5faff"), 3.0)
			draw_line(Vector2(0, -12), Vector2(0, 11), Color("8ea4b9"), 2.0)
		elif id == "chain_armor":
			draw_colored_polygon(PackedVector2Array([Vector2(-12, -18), Vector2(-22, -8), Vector2(-17, 6), Vector2(-10, 2), Vector2(-10, 20), Vector2(10, 20), Vector2(10, 2), Vector2(17, 6), Vector2(22, -8), Vector2(12, -18)]), Color("9aaebe"))
			draw_rect(Rect2(-8, -13, 16, 8), Color("dfe8ef"))
			draw_line(Vector2(0, -10), Vector2(0, 16), Color("e7f0f7"), 3.0)
			draw_line(Vector2(-9, 1), Vector2(9, 1), Color("7a8d9e"), 2.0)
		else:
			draw_colored_polygon(PackedVector2Array([Vector2(-12, -18), Vector2(-21, -8), Vector2(-17, 5), Vector2(-10, 2), Vector2(-10, 20), Vector2(10, 20), Vector2(10, 2), Vector2(17, 5), Vector2(21, -8), Vector2(12, -18)]), Color("8667ac"))
			draw_rect(Rect2(-9, -14, 18, 8), Color("cdb8ea"))
			draw_line(Vector2(0, -11), Vector2(0, 16), Color("eadf9a"), 3.0)
	elif id.ends_with("legs") or id.ends_with("pants") or id == "leather_leggings":
		var leg_fill := Color("aebfd3") if id == "plate_legs" else Color("6d81aa")
		var leg_high := Color("edf4fa") if id == "plate_legs" else Color("9fb4da")
		draw_colored_polygon(PackedVector2Array([Vector2(-14, -19), Vector2(14, -19), Vector2(12, 18), Vector2(4, 18), Vector2(1, -1), Vector2(-1, -1), Vector2(-4, 18), Vector2(-12, 18)]), leg_fill)
		draw_rect(Rect2(-14, -18, 28, 5), brown)
		draw_rect(Rect2(-9, -8, 7, 22), leg_high)
		draw_rect(Rect2(2, -8, 7, 22), leg_high)
	elif id == "short_bow":
		draw_arc(Vector2(-5, 0), 21.0, -PI / 2.0, PI / 2.0, 16, brown, 4.0)
		draw_line(Vector2(-5, -21), Vector2(-5, 21), steel, 2.0)
	elif id == "quiver":
		draw_rect(Rect2(-12, -11, 24, 29), brown)
		for i in range(3):
			draw_line(Vector2(-8 + i * 7, -25), Vector2(-8 + i * 7, -6), steel, 2.0)
	elif id == "spellbook" or id == "holy_book":
		draw_rect(Rect2(-17, -17, 34, 34), Color("8a67b3"))
		draw_rect(Rect2(-12, -13, 25, 26), Color("b59fe0"))
		draw_line(Vector2(-4, -12), Vector2(-4, 12), dark, 3.0)
		draw_circle(Vector2(6, 0), 5.0, gold)
	elif id == "apprentice_wand" or id == "priest_staff" or id == "sorcerer_staff" or id == "cleric_sceptre":
		draw_line(Vector2(-9, 19), Vector2(8, -21), brown, 5.0)
		draw_circle(Vector2(9, -23), 7.0, Color("9fd4fa") if id == "apprentice_wand" else gold)
	elif id == "cleric_mace":
		draw_line(Vector2(-7, 22), Vector2(6, -16), brown, 6.0)
		draw_rect(Rect2(-9, -29, 24, 16), steel)
		draw_line(Vector2(-8, -27), Vector2(13, -27), gold, 3.0)
	elif id == "holy_relic":
		draw_circle(Vector2.ZERO, 17, gold)
		draw_line(Vector2(0, -12), Vector2(0, 12), dark, 5.0)
		draw_line(Vector2(-9, -2), Vector2(9, -2), dark, 5.0)
	draw_set_transform(Vector2.ZERO)

func draw_shop() -> void:
	draw_rect(Rect2(111, 72, 738, 385), Color("111b2b"))
	draw_rect(Rect2(111, 72, 738, 385), Color("ead19d"), false, 3.0)
	draw_label("ROYAL ARMS MERCHANT", Vector2(242, 123), 28, Color("ffe2a4"))
	draw_label("God Sword", Vector2(402, 192), 26, Color("f9dc77"))
	draw_item_icon("god_sword", Vector2(300, 246), 2.0)
	draw_label("Knight weapon - melee swing", Vector2(399, 233), 17, Color("d8e3ee"))
	draw_label("On hit: seeks nearest enemy within 5 tiles", Vector2(399, 262), 16, Color("b8e9f5"))
	draw_label("Price: 100 gold", Vector2(402, 298), 20, Color("f8d289"))
	draw_label("Your gold: %d" % int(slots[active_slot]["gold"]), Vector2(402, 322), 17, Color("f3d699"))
	draw_rect(SHOP_BUY_BUTTON, Color("496a46"))
	draw_rect(SHOP_BUY_BUTTON, Color("a7e2ac"), false, 2.0)
	draw_label("BUY GOD SWORD", Vector2(373, 393), 22, Color.WHITE)
	draw_rect(SHOP_CLOSE_BUTTON, Color("8d484a"))
	draw_label("X", Vector2(800, 137), 27, Color.WHITE)
	if active_slot != 0:
		draw_label("Only Knights can equip this weapon", Vector2(312, 435), 16, Color("f5a9a9"))

func draw_label(text_value: String, point: Vector2, font_size: int = 18, color: Color = Color.WHITE) -> void:
	draw_string(ThemeDB.fallback_font, point, text_value, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)

func draw_warrior_player(center: Vector2) -> void:
	# Warrior updated to resemble a classic armored knight with a blue cape,
	# silver plate armor, red crest, and a broad shield.
	var dir_name := "down"
	if absf(facing_direction.x) > absf(facing_direction.y):
		dir_name = "right" if facing_direction.x >= 0.0 else "left"
	else:
		dir_name = "down" if facing_direction.y >= 0.0 else "up"

	var outline := Color("101923")
	var silver_dark := Color("6f87a0")
	var silver_mid := Color("aabed0")
	var silver_light := Color("e3edf4")
	var blue_dark := Color("1e3f9a")
	var blue_bright := Color("2f78d7")
	var red_crest := Color("d92a22")
	var leather := Color("8d5d3b")
	var shield_fill := Color("a6bbca")
	var shield_edge := Color("eef4f8")
	var trim := Color("e2b04d")
	var holy_blade: bool = item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "god_sword"

	# Back cape
	match dir_name:
		"down":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-18, -10), center + Vector2(-28, 10), center + Vector2(-20, 28),
				center + Vector2(-6, 24), center + Vector2(-2, 4)
			]), blue_dark)
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(18, -10), center + Vector2(28, 10), center + Vector2(20, 28),
				center + Vector2(6, 24), center + Vector2(2, 4)
			]), blue_bright)
		"up":
			draw_rect(Rect2(center + Vector2(-17, -3), Vector2(34, 26)), blue_dark)
		"left":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(2, -10), center + Vector2(-22, -2), center + Vector2(-26, 24),
				center + Vector2(-2, 20), center + Vector2(7, 5)
			]), blue_dark)
		"right":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-2, -10), center + Vector2(22, -2), center + Vector2(26, 24),
				center + Vector2(2, 20), center + Vector2(-7, 5)
			]), blue_dark)

	# Legs and feet
	draw_rect(Rect2(center + Vector2(-10, 12), Vector2(7, 9)), silver_mid)
	draw_rect(Rect2(center + Vector2(3, 12), Vector2(7, 9)), silver_mid)
	draw_rect(Rect2(center + Vector2(-11, 20), Vector2(8, 3)), silver_dark)
	draw_rect(Rect2(center + Vector2(3, 20), Vector2(8, 3)), silver_dark)
	# Waist and torso
	draw_rect(Rect2(center + Vector2(-13, 7), Vector2(26, 5)), leather)
	draw_rect(Rect2(center + Vector2(-12, -6), Vector2(24, 16)), silver_mid)
	draw_rect(Rect2(center + Vector2(-12, -6), Vector2(24, 3)), silver_light)
	draw_rect(Rect2(center + Vector2(-17, -3), Vector2(6, 10)), blue_bright)
	draw_rect(Rect2(center + Vector2(11, -3), Vector2(6, 10)), blue_bright)
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-8, -6), center + Vector2(8, -6), center + Vector2(0, 2)
	]), silver_light)
	# Head / helmet
	draw_rect(Rect2(center + Vector2(-10, -22), Vector2(20, 16)), silver_mid)
	draw_rect(Rect2(center + Vector2(-10, -22), Vector2(20, 3)), silver_light)
	draw_rect(Rect2(center + Vector2(-6, -18), Vector2(12, 9)), silver_light)
	match dir_name:
		"down":
			draw_rect(Rect2(center + Vector2(-7, -15), Vector2(14, 3)), outline)
			draw_rect(Rect2(center + Vector2(-2, -14), Vector2(4, 8)), outline)
		"up":
			draw_rect(Rect2(center + Vector2(-8, -22), Vector2(16, 2)), silver_dark)
		"left":
			draw_rect(Rect2(center + Vector2(-7, -15), Vector2(8, 3)), outline)
			draw_rect(Rect2(center + Vector2(-3, -14), Vector2(3, 7)), outline)
		"right":
			draw_rect(Rect2(center + Vector2(-1, -15), Vector2(8, 3)), outline)
			draw_rect(Rect2(center + Vector2(0, -14), Vector2(3, 7)), outline)
	# Red crest plume
	match dir_name:
		"down":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-3, -25), center + Vector2(4, -25), center + Vector2(11, -34), center + Vector2(9, -40),
				center + Vector2(3, -39), center + Vector2(-2, -31)
			]), red_crest)
		"up":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-3, -24), center + Vector2(4, -24), center + Vector2(11, -34), center + Vector2(8, -41),
				center + Vector2(1, -39), center + Vector2(-4, -30)
			]), red_crest)
		"left":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-1, -24), center + Vector2(5, -24), center + Vector2(7, -32), center + Vector2(0, -39),
				center + Vector2(-8, -36), center + Vector2(-3, -29)
			]), red_crest)
		"right":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-5, -24), center + Vector2(1, -24), center + Vector2(3, -32), center + Vector2(10, -39),
				center + Vector2(18, -36), center + Vector2(13, -29)
			]), red_crest)

	# Shield and sword placement per direction.
	var shield_points := PackedVector2Array()
	var sword_base := center
	var sword_tip := center
	var cross_left := center
	var cross_right := center
	var slash_points := PackedVector2Array()

	match dir_name:
		"down":
			shield_points = PackedVector2Array([
				center + Vector2(12, -8), center + Vector2(26, -8), center + Vector2(26, 16),
				center + Vector2(20, 24), center + Vector2(12, 16)
			])
			var sword_angle := -0.45
			if warrior_swing_timer > 0.0:
				var progress := 1.0 - warrior_swing_timer / WARRIOR_SWING_DURATION
				sword_angle = lerpf(-1.85, 1.1, progress)
			sword_base = center + Vector2(-10, 4)
			sword_tip = sword_base + Vector2(0, -38).rotated(sword_angle)
			cross_left = sword_base + Vector2(-6, -4).rotated(sword_angle)
			cross_right = sword_base + Vector2(6, -4).rotated(sword_angle)
			if warrior_slash_flash > 0.0:
				for i in range(11):
					var t := float(i) / 10.0
					var a := lerpf(-1.4, 1.0, t)
					slash_points.append(center + Vector2(-2, -56).rotated(a))
		"up":
			shield_points = PackedVector2Array([
				center + Vector2(-26, -8), center + Vector2(-12, -8), center + Vector2(-12, 16),
				center + Vector2(-18, 24), center + Vector2(-26, 16)
			])
			var sword_angle := 3.14
			if warrior_swing_timer > 0.0:
				var progress := 1.0 - warrior_swing_timer / WARRIOR_SWING_DURATION
				sword_angle = lerpf(2.1, 4.2, progress)
			sword_base = center + Vector2(10, 4)
			sword_tip = sword_base + Vector2(0, -38).rotated(sword_angle)
			cross_left = sword_base + Vector2(-6, -4).rotated(sword_angle)
			cross_right = sword_base + Vector2(6, -4).rotated(sword_angle)
			if warrior_slash_flash > 0.0:
				for i in range(11):
					var t := float(i) / 10.0
					var a := lerpf(2.0, 4.35, t)
					slash_points.append(center + Vector2(2, -56).rotated(a))
		"left":
			shield_points = PackedVector2Array([
				center + Vector2(-28, -10), center + Vector2(-12, -10), center + Vector2(-12, 14),
				center + Vector2(-18, 23), center + Vector2(-28, 16)
			])
			var sword_angle := -1.65
			if warrior_swing_timer > 0.0:
				var progress := 1.0 - warrior_swing_timer / WARRIOR_SWING_DURATION
				sword_angle = lerpf(-3.0, -0.35, progress)
			sword_base = center + Vector2(4, 2)
			sword_tip = sword_base + Vector2(0, -36).rotated(sword_angle)
			cross_left = sword_base + Vector2(-6, -4).rotated(sword_angle)
			cross_right = sword_base + Vector2(6, -4).rotated(sword_angle)
			if warrior_slash_flash > 0.0:
				for i in range(11):
					var t := float(i) / 10.0
					var a := lerpf(-2.8, -0.35, t)
					slash_points.append(center + Vector2(-8, -50).rotated(a))
		"right":
			shield_points = PackedVector2Array([
				center + Vector2(12, -10), center + Vector2(28, -10), center + Vector2(28, 14),
				center + Vector2(18, 23), center + Vector2(12, 16)
			])
			var sword_angle := 1.65
			if warrior_swing_timer > 0.0:
				var progress := 1.0 - warrior_swing_timer / WARRIOR_SWING_DURATION
				sword_angle = lerpf(0.35, 3.0, progress)
			sword_base = center + Vector2(-4, 2)
			sword_tip = sword_base + Vector2(0, -36).rotated(sword_angle)
			cross_left = sword_base + Vector2(-6, -4).rotated(sword_angle)
			cross_right = sword_base + Vector2(6, -4).rotated(sword_angle)
			if warrior_slash_flash > 0.0:
				for i in range(11):
					var t := float(i) / 10.0
					var a := lerpf(0.35, 2.8, t)
					slash_points.append(center + Vector2(8, -50).rotated(a))

	# Shield is only drawn when a shield is actually equipped; two-handed
	# greatswords use both hands and never display a floating offhand shield.
	var equipped_weapon_id: String = str(slots[active_slot]["equipment"].get("weapon", ""))
	var visual_two_handed: bool = is_two_handed_weapon(equipped_weapon_id)
	var equipped_offhand_id: String = str(slots[active_slot]["equipment"].get("offhand", ""))
	if not visual_two_handed and item_base_id(equipped_offhand_id).ends_with("shield"):
		draw_colored_polygon(shield_points, shield_fill)
		draw_polyline(shield_points, shield_edge, 2.2, true)
		if shield_points.size() >= 4:
			var stripe_rect: Rect2 = Rect2((shield_points[0] + shield_points[2]) * 0.5 - Vector2(3, 11), Vector2(6, 22))
			draw_rect(stripe_rect, Color("f7fbff"))
	if visual_two_handed:
		# Enlarge the blade for the two-handed stance, retaining its direction.
		sword_tip = sword_base + (sword_tip - sword_base) * 1.48
		if warrior_slash_flash > 0.0:
			slash_points.clear()
			# Two-handed sword sweeps a 220-degree sector centered on facing.
			for sweep_index in range(29):
				var relative_angle: float = deg_to_rad(-110.0 + 220.0 * float(sweep_index) / 28.0)
				slash_points.append(center + warrior_swing_direction.rotated(relative_angle) * 104.0)

	# Weapon render, preserving God Sword special appearance.
	# No drawn sword when the player has unequipped the weapon.
	var grip_dir := (sword_tip - sword_base).normalized()
	if equipped_weapon_id == "":
		pass
	elif holy_blade:
		var blade_dir := (sword_tip - sword_base)
		draw_line(sword_base, sword_tip, Color("1b2633"), 8.0)
		draw_line(sword_base, sword_tip, Color("74dfff"), 6.0)
		draw_line(sword_base + blade_dir * 0.10, sword_tip - blade_dir * 0.06, Color("f6fdff"), 2.6)
		var fork_points1 := PackedVector2Array([
			sword_base + blade_dir * 0.20,
			sword_base + blade_dir * 0.34 + Vector2(-grip_dir.y, grip_dir.x) * 5.0,
			sword_base + blade_dir * 0.45 + Vector2(grip_dir.y, -grip_dir.x) * 4.0,
			sword_base + blade_dir * 0.60
		])
		var fork_points2 := PackedVector2Array([
			sword_base + blade_dir * 0.42,
			sword_base + blade_dir * 0.54 + Vector2(grip_dir.y, -grip_dir.x) * 4.0,
			sword_base + blade_dir * 0.70 + Vector2(-grip_dir.y, grip_dir.x) * 3.0,
			sword_base + blade_dir * 0.84
		])
		draw_polyline(fork_points1, Color("acf8ff"), 2.0, false)
		draw_polyline(fork_points2, Color("8ae7ff"), 2.0, false)
		draw_line(cross_left, cross_right, Color("111923"), 5.0)
		draw_line(cross_left * 0.7 + cross_right * 0.3, cross_left * 0.3 + cross_right * 0.7, Color("233140"), 2.0)
		draw_line(sword_base, sword_base - grip_dir * 8.0, Color("16202b"), 4.0)
		draw_circle(sword_base - grip_dir * 8.8, 2.8, Color("1a2634"))
	else:
		draw_line(sword_base, sword_tip, silver_light, 5.5)
		draw_line(sword_base, sword_tip, silver_mid, 2.0)
		draw_line(cross_left, cross_right, trim, 3.5)
		draw_line(sword_base, sword_base - grip_dir * 7.5, leather, 3.0)
	# Swing slash
	if warrior_slash_flash > 0.0 and slash_points.size() > 1:
		draw_polyline(slash_points, Color(1.0, 0.97, 0.75, minf(1.0, warrior_slash_flash * 5.0)), 3.0, false)


func class_dir_name() -> String:
	if absf(facing_direction.x) > absf(facing_direction.y):
		return "right" if facing_direction.x >= 0.0 else "left"
	return "down" if facing_direction.y >= 0.0 else "up"

func draw_archer_player(center: Vector2) -> void:
	var dir_name := class_dir_name()
	var hood_dark := Color("355d24")
	var hood_mid := Color("4d7f31")
	var hood_light := Color("7aa35b")
	var leather := Color("7a4f2a")
	var leather_dark := Color("54341b")
	var skin := Color("f1cfaf")
	var hair := Color("9d6432")
	var metal := Color("b5c3c9")
	var cloak := Color("416e29")
	var quiver := Color("74522e")
	var arrow_feather := Color("e7f0d4")
	var outline := Color("192216")

	# Back cloak and quiver.
	var quiver_equipped: bool = item_base_id(str(slots[active_slot]["equipment"].get("offhand", ""))) == "quiver"
	match dir_name:
		"down":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-16, -6), center + Vector2(-24, 10), center + Vector2(-20, 24),
				center + Vector2(-6, 20), center + Vector2(-2, 2)
			]), cloak)
			if quiver_equipped:
				var q := center + Vector2(-13, -18)
				draw_rect(Rect2(q, Vector2(10, 17)), quiver)
				for i in range(3):
					draw_line(q + Vector2(2 + i * 3, 0), q + Vector2(2 + i * 3, -9), leather_dark, 2.0)
					draw_line(q + Vector2(2 + i * 3, -9), q + Vector2(2 + i * 3, -13), arrow_feather, 2.0)
		"up":
			draw_rect(Rect2(center + Vector2(-14, -4), Vector2(28, 23)), cloak)
			if quiver_equipped:
				var q2 := center + Vector2(4, -20)
				draw_rect(Rect2(q2, Vector2(10, 17)), quiver)
				for i in range(3):
					draw_line(q2 + Vector2(2 + i * 3, 0), q2 + Vector2(2 + i * 3, -9), leather_dark, 2.0)
					draw_line(q2 + Vector2(2 + i * 3, -9), q2 + Vector2(2 + i * 3, -13), arrow_feather, 2.0)
		"left":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(3, -7), center + Vector2(-21, -2), center + Vector2(-24, 23),
				center + Vector2(-1, 20), center + Vector2(8, 2)
			]), cloak)
		"right":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-3, -7), center + Vector2(21, -2), center + Vector2(24, 23),
				center + Vector2(1, 20), center + Vector2(-8, 2)
			]), cloak)

	# Legs and boots.
	draw_rect(Rect2(center + Vector2(-10, 12), Vector2(7, 8)), Color("5d5f58"))
	draw_rect(Rect2(center + Vector2(3, 12), Vector2(7, 8)), Color("5d5f58"))
	draw_rect(Rect2(center + Vector2(-12, 19), Vector2(9, 4)), leather_dark)
	draw_rect(Rect2(center + Vector2(3, 19), Vector2(9, 4)), leather_dark)
	# Torso.
	draw_rect(Rect2(center + Vector2(-12, -4), Vector2(24, 17)), hood_mid)
	draw_rect(Rect2(center + Vector2(-7, 2), Vector2(14, 11)), hood_dark)
	draw_rect(Rect2(center + Vector2(-13, 6), Vector2(26, 4)), leather)
	draw_rect(Rect2(center + Vector2(-3, 6), Vector2(6, 4)), Color("d7b661"))
	draw_rect(Rect2(center + Vector2(-17, -1), Vector2(5, 10)), skin)
	draw_rect(Rect2(center + Vector2(12, -1), Vector2(5, 10)), skin)
	draw_rect(Rect2(center + Vector2(-18, 0), Vector2(6, 10)), leather)
	draw_rect(Rect2(center + Vector2(12, 0), Vector2(6, 10)), leather)

	# Hood and face.
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-14, -21), center + Vector2(14, -21), center + Vector2(10, -7),
		center + Vector2(-10, -7)
	]), hood_mid)
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-14, -19), center + Vector2(0, -31), center + Vector2(14, -19),
		center + Vector2(10, -7), center + Vector2(-10, -7)
	]), hood_dark)
	match dir_name:
		"down":
			draw_rect(Rect2(center + Vector2(-7, -17), Vector2(14, 9)), skin)
			draw_rect(Rect2(center + Vector2(-7, -19), Vector2(14, 3)), hair)
			draw_rect(Rect2(center + Vector2(-5, -13), Vector2(3, 3)), outline)
			draw_rect(Rect2(center + Vector2(2, -13), Vector2(3, 3)), outline)
		"up":
			draw_rect(Rect2(center + Vector2(-8, -20), Vector2(16, 3)), hood_light)
		"left":
			draw_rect(Rect2(center + Vector2(-8, -17), Vector2(9, 8)), skin)
			draw_rect(Rect2(center + Vector2(-8, -19), Vector2(9, 3)), hair)
			draw_rect(Rect2(center + Vector2(-4, -13), Vector2(3, 3)), outline)
		"right":
			draw_rect(Rect2(center + Vector2(-1, -17), Vector2(9, 8)), skin)
			draw_rect(Rect2(center + Vector2(-1, -19), Vector2(9, 3)), hair)
			draw_rect(Rect2(center + Vector2(1, -13), Vector2(3, 3)), outline)

	# Show the bow only when actually equipped; the preview uses the same art.
	var bow_equipped: bool = item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "short_bow"
	if bow_equipped:
		var bow_side := 1.0 if dir_name != "left" else -1.0
		var bow_base := center + Vector2(bow_side * 17.0, 1)
		var bow_top := bow_base + Vector2(0, -18)
		var bow_bottom := bow_base + Vector2(0, 18)
		var bow_mid := bow_base + Vector2(bow_side * 5.0, 0)
		draw_polyline(PackedVector2Array([bow_top, bow_mid, bow_bottom]), leather_dark, 3.2, false)
		draw_line(bow_top, bow_bottom, Color("d8d8c2"), 1.4)
		if dir_name == "left" or dir_name == "right":
			draw_line(center + Vector2(bow_side * 9.0, -1), center + Vector2(bow_side * 24.0, -8), metal, 2.0)
			draw_line(center + Vector2(bow_side * 24.0, -8), center + Vector2(bow_side * 27.0, -8), arrow_feather, 2.0)

func draw_sorcerer_player(center: Vector2) -> void:
	var dir_name := class_dir_name()
	var robe_dark := Color("34174d")
	var robe_mid := Color("56257f")
	var robe_light := Color("8b46cc")
	var hood_high := Color("6d31aa")
	var skin := Color("b86f58")
	var staff_wood := Color("5c3f2b")
	var crystal := Color("c04eff")
	var glow := Color("28de95")
	var outline := Color("130b1d")
	var has_staff := item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "sorcerer_staff"
	var has_book := item_base_id(str(slots[active_slot]["equipment"].get("offhand", ""))) == "spellbook"

	# Back robe.
	match dir_name:
		"down":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-18, -5), center + Vector2(-24, 22), center + Vector2(-10, 28),
				center + Vector2(-3, 11), center + Vector2(0, 0), center + Vector2(3, 11),
				center + Vector2(10, 28), center + Vector2(24, 22), center + Vector2(18, -5)
			]), robe_dark)
		"up":
			draw_rect(Rect2(center + Vector2(-15, -2), Vector2(30, 28)), robe_dark)
		"left":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(4, -5), center + Vector2(-22, 1), center + Vector2(-20, 27),
				center + Vector2(0, 23), center + Vector2(8, 8)
			]), robe_dark)
		"right":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-4, -5), center + Vector2(22, 1), center + Vector2(20, 27),
				center + Vector2(0, 23), center + Vector2(-8, 8)
			]), robe_dark)

	draw_rect(Rect2(center + Vector2(-11, 12), Vector2(7, 9)), Color("16161c"))
	draw_rect(Rect2(center + Vector2(4, 12), Vector2(7, 9)), Color("16161c"))
	draw_rect(Rect2(center + Vector2(-14, -4), Vector2(28, 19)), robe_mid)
	draw_rect(Rect2(center + Vector2(-4, -1), Vector2(8, 16)), robe_light)
	draw_rect(Rect2(center + Vector2(-19, -1), Vector2(5, 11)), skin)
	draw_rect(Rect2(center + Vector2(14, -1), Vector2(5, 11)), skin)

	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-14, -22), center + Vector2(0, -29), center + Vector2(14, -22),
		center + Vector2(11, -6), center + Vector2(-11, -6)
	]), robe_mid)
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-10, -18), center + Vector2(10, -18), center + Vector2(8, -7), center + Vector2(-8, -7)
	]), robe_dark)
	match dir_name:
		"down":
			draw_rect(Rect2(center + Vector2(-7, -17), Vector2(14, 9)), skin)
			draw_rect(Rect2(center + Vector2(-5, -13), Vector2(3, 3)), Color("ffd56e"))
			draw_rect(Rect2(center + Vector2(2, -13), Vector2(3, 3)), Color("ffd56e"))
		"left":
			draw_rect(Rect2(center + Vector2(-8, -17), Vector2(9, 8)), skin)
			draw_rect(Rect2(center + Vector2(-4, -13), Vector2(3, 3)), Color("ffd56e"))
		"right":
			draw_rect(Rect2(center + Vector2(-1, -17), Vector2(9, 8)), skin)
			draw_rect(Rect2(center + Vector2(1, -13), Vector2(3, 3)), Color("ffd56e"))
		"up":
			draw_rect(Rect2(center + Vector2(-8, -22), Vector2(16, 2)), hood_high)

	# Weapon / casting visuals.
	if has_staff:
		var side := -1.0 if dir_name != "left" else 1.0
		var root := center + Vector2(side * 14.0, 13)
		var tip := root + Vector2(side * -2.0, -38)
		draw_line(root, tip, staff_wood, 3.2)
		draw_circle(tip + Vector2(0, -2), 6.0, crystal)
		draw_circle(tip + Vector2(0, -2), 11.0, Color(0.76, 0.31, 1.0, 0.18))
		draw_line(tip + Vector2(-6, 3), tip + Vector2(0, -7), robe_dark, 2.4)
		draw_line(tip + Vector2(6, 3), tip + Vector2(0, -7), robe_dark, 2.4)
	elif item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "apprentice_wand":
		var wand_side := 1.0
		var wand_root := center + Vector2(wand_side * 14.0, 6)
		var wand_tip := wand_root + Vector2(wand_side * 7.0, -20)
		draw_line(wand_root, wand_tip, staff_wood, 3.0)
		draw_circle(wand_tip, 4.5, crystal)
	if has_book:
		var book_pos := center + Vector2(-23, -2)
		draw_rect(Rect2(book_pos, Vector2(13, 11)), Color("24313f"))
		draw_rect(Rect2(book_pos + Vector2(2, 1), Vector2(9, 9)), Color("2b4757"))
		draw_line(book_pos + Vector2(6, 1), book_pos + Vector2(6, 10), Color("a1c9dc"), 1.5)
	# Floating spell orb.
	var orb := center + Vector2(20, -2)
	draw_circle(orb, 7.5, Color("102326"))
	draw_circle(orb, 5.0, glow)
	for spark in [Vector2(10, -7), Vector2(5, 8), Vector2(-4, -10), Vector2(-10, 3)]:
		draw_circle(orb + spark, 1.8, Color("a650ff"))

func draw_cleric_player(center: Vector2) -> void:
	var dir_name := class_dir_name()
	var robe_white := Color("e9edf4")
	var robe_gray := Color("c7d0dd")
	var hood_shadow := Color("95a5bb")
	var blue := Color("2c61c7")
	var gold := Color("dfba58")
	var skin := Color("f0c9a9")
	var dark := Color("1c2027")
	var has_sceptre := item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "cleric_sceptre"
	var has_book := item_base_id(str(slots[active_slot]["equipment"].get("offhand", ""))) == "holy_book"

	# Robe back silhouette.
	match dir_name:
		"down":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-18, -7), center + Vector2(-23, 23), center + Vector2(-8, 29),
				center + Vector2(-2, 9), center + Vector2(0, 2), center + Vector2(2, 9),
				center + Vector2(8, 29), center + Vector2(23, 23), center + Vector2(18, -7)
			]), robe_white)
		"up":
			draw_rect(Rect2(center + Vector2(-16, -4), Vector2(32, 28)), robe_white)
		"left":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(4, -7), center + Vector2(-21, 0), center + Vector2(-19, 26),
				center + Vector2(0, 22), center + Vector2(7, 6)
			]), robe_white)
		"right":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-4, -7), center + Vector2(21, 0), center + Vector2(19, 26),
				center + Vector2(0, 22), center + Vector2(-7, 6)
			]), robe_white)

	draw_rect(Rect2(center + Vector2(-10, 12), Vector2(7, 10)), dark)
	draw_rect(Rect2(center + Vector2(3, 12), Vector2(7, 10)), dark)
	draw_rect(Rect2(center + Vector2(-13, -5), Vector2(26, 18)), robe_gray)
	draw_rect(Rect2(center + Vector2(-4, -2), Vector2(8, 18)), gold)
	draw_rect(Rect2(center + Vector2(-17, -2), Vector2(4, 11)), Color("b0bac5"))
	draw_rect(Rect2(center + Vector2(13, -2), Vector2(4, 11)), Color("b0bac5"))
	draw_rect(Rect2(center + Vector2(8, 0), Vector2(8, 12)), blue)

	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-13, -22), center + Vector2(0, -31), center + Vector2(13, -22),
		center + Vector2(10, -6), center + Vector2(-10, -6)
	]), robe_white)
	match dir_name:
		"down":
			draw_rect(Rect2(center + Vector2(-7, -17), Vector2(14, 9)), skin)
			draw_rect(Rect2(center + Vector2(-5, -13), Vector2(3, 3)), Color("a46f4f"))
			draw_rect(Rect2(center + Vector2(2, -13), Vector2(3, 3)), Color("a46f4f"))
		"left":
			draw_rect(Rect2(center + Vector2(-8, -17), Vector2(9, 8)), skin)
			draw_rect(Rect2(center + Vector2(-4, -13), Vector2(3, 3)), Color("a46f4f"))
		"right":
			draw_rect(Rect2(center + Vector2(-1, -17), Vector2(9, 8)), skin)
			draw_rect(Rect2(center + Vector2(1, -13), Vector2(3, 3)), Color("a46f4f"))
		"up":
			draw_rect(Rect2(center + Vector2(-8, -22), Vector2(16, 2)), hood_shadow)
	# Halo.
	for ray in range(8):
		var ang := TAU * float(ray) / 8.0
		var inner := center + Vector2(0, -27) + Vector2.RIGHT.rotated(ang) * 7.0
		var outer := center + Vector2(0, -27) + Vector2.RIGHT.rotated(ang) * 13.0
		draw_line(inner, outer, gold, 1.5)
	draw_circle(center + Vector2(0, -27), 6.0, Color(0.95, 0.96, 1.0, 0.28))
	if has_sceptre:
		var side := -1.0 if dir_name != "left" else 1.0
		var root := center + Vector2(side * 14.0, 13)
		var tip := root + Vector2(side * -2.0, -38)
		draw_line(root, tip, gold, 3.0)
		draw_circle(tip + Vector2(0, -2), 6.5, gold)
		draw_circle(tip + Vector2(0, -2), 3.0, Color("67b7ff"))
		for ray in range(4):
			var ang2 := TAU * float(ray) / 4.0 + PI / 4.0
			draw_line(tip + Vector2(0, -2), tip + Vector2(0, -2) + Vector2.RIGHT.rotated(ang2) * 10.0, gold, 1.8)
	elif item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "cleric_mace":
		var mace_root := center + Vector2(15, 8)
		var mace_tip := mace_root + Vector2(4, -22)
		draw_line(mace_root, mace_tip, Color("84684d"), 3.0)
		draw_circle(mace_tip, 5.0, Color("d7d9dd"))
		draw_line(mace_tip + Vector2(-4, 0), mace_tip + Vector2(4, 0), Color("a5abb4"), 2.0)
	if has_book:
		var book_pos := center + Vector2(-22, -1)
		draw_rect(Rect2(book_pos, Vector2(12, 11)), Color("315dab"))
		draw_rect(Rect2(book_pos + Vector2(2, 1), Vector2(8, 9)), Color("e9ebef"))
		draw_line(book_pos + Vector2(6, 1), book_pos + Vector2(6, 10), gold, 1.2)

func draw_rogue_player(center: Vector2) -> void:
	var dir_name := class_dir_name()
	var hood_dark := Color("182022")
	var hood_mid := Color("27362f")
	var hood_green := Color("436938")
	var leather_dark := Color("2d2a2e")
	var leather_mid := Color("4a464e")
	var leather_brown := Color("6f4a31")
	var cloak := Color("10171a")
	var blade := Color("d5dcdd")
	var blade_dark := Color("7f8f99")
	var eye := Color("82d58f")
	var strap := Color("70553a")
	var offhand_dagger := item_base_id(str(slots[active_slot]["equipment"].get("offhand", ""))) == "rogue_offhand_dagger"

	# Cloak.
	match dir_name:
		"down":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-17, -5), center + Vector2(-24, 16), center + Vector2(-16, 27),
				center + Vector2(-4, 20), center + Vector2(0, 2), center + Vector2(4, 20),
				center + Vector2(16, 27), center + Vector2(24, 16), center + Vector2(17, -5)
			]), cloak)
		"up":
			draw_rect(Rect2(center + Vector2(-16, -4), Vector2(32, 24)), cloak)
		"left":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(4, -6), center + Vector2(-24, -1), center + Vector2(-20, 26),
				center + Vector2(-1, 20), center + Vector2(6, 6)
			]), cloak)
		"right":
			draw_colored_polygon(PackedVector2Array([
				center + Vector2(-4, -6), center + Vector2(24, -1), center + Vector2(20, 26),
				center + Vector2(1, 20), center + Vector2(-6, 6)
			]), cloak)

	draw_rect(Rect2(center + Vector2(-10, 13), Vector2(7, 9)), leather_mid)
	draw_rect(Rect2(center + Vector2(3, 13), Vector2(7, 9)), leather_mid)
	draw_rect(Rect2(center + Vector2(-12, 20), Vector2(8, 3)), Color("17181a"))
	draw_rect(Rect2(center + Vector2(4, 20), Vector2(8, 3)), Color("17181a"))
	draw_rect(Rect2(center + Vector2(-12, -4), Vector2(24, 17)), hood_mid)
	draw_rect(Rect2(center + Vector2(-8, 0), Vector2(16, 10)), leather_dark)
	draw_line(center + Vector2(-9, 2), center + Vector2(9, 2), strap, 2.0)
	draw_line(center + Vector2(-6, -3), center + Vector2(7, 12), strap, 2.0)
	draw_circle(center + Vector2(10, 4), 2.1, leather_brown)
	draw_circle(center + Vector2(-11, 4), 2.1, leather_brown)

	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-14, -22), center + Vector2(0, -31), center + Vector2(14, -22),
		center + Vector2(10, -6), center + Vector2(-10, -6)
	]), hood_mid)
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-9, -19), center + Vector2(9, -19), center + Vector2(7, -8), center + Vector2(-7, -8)
	]), hood_dark)
	match dir_name:
		"down":
			draw_rect(Rect2(center + Vector2(-4, -15), Vector2(3, 3)), eye)
			draw_rect(Rect2(center + Vector2(1, -15), Vector2(3, 3)), eye)
		"left":
			draw_rect(Rect2(center + Vector2(-3, -15), Vector2(3, 3)), eye)
		"right":
			draw_rect(Rect2(center + Vector2(0, -15), Vector2(3, 3)), eye)
	# Dagger(s).
	var daggers: Array = []
	if item_base_id(str(slots[active_slot]["equipment"].get("weapon", ""))) == "rogue_dagger":
		daggers.append(1.0)
	if offhand_dagger:
		daggers.append(-1.0)
	for side in daggers:
		var root := center + Vector2(side * 14.0, 6)
		var tip := root + Vector2(side * 12.0, -6.0)
		draw_line(root, tip, blade, 3.2)
		draw_line(root, tip, blade_dark, 1.2)
		draw_line(root + Vector2(-side * 3.0, 1.0), root + Vector2(side * 3.0, 1.0), leather_brown, 2.4)

func draw_default_player(center: Vector2) -> void:
	match active_slot:
		1:
			draw_archer_player(center)
		2:
			draw_sorcerer_player(center)
		3:
			draw_cleric_player(center)
		4:
			draw_rogue_player(center)
		_:
			draw_set_transform(center, facing_direction.angle() + PI * 0.5)
			draw_rect(Rect2(Vector2(-12, -15), Vector2(24, 30)), COLORS[active_slot])
			draw_rect(Rect2(Vector2(-6, -7), Vector2(4, 5)), Color("1c2330"))
			draw_rect(Rect2(Vector2(3, -7), Vector2(4, 5)), Color("1c2330"))
			draw_colored_polygon(PackedVector2Array([Vector2(-5, -15), Vector2(5, -15), Vector2(0, -22)]), Color("fff2cf"))
			draw_set_transform(Vector2.ZERO)

func draw_town_building(world_center: Vector2, camera: Vector2, house_color: Color, sign_text: String) -> void:
	var p: Vector2 = world_center - camera
	# Stone foundations, timber facades and terracotta roofs.
	draw_rect(Rect2(p + Vector2(-43, -22), Vector2(86, 60)), Color("52463d"))
	draw_rect(Rect2(p + Vector2(-39, -18), Vector2(78, 50)), house_color)
	draw_colored_polygon(PackedVector2Array([p + Vector2(-49, -20), p + Vector2(0, -58), p + Vector2(49, -20)]), Color("934d3b"))
	draw_line(p + Vector2(-49, -20), p + Vector2(49, -20), Color("d9a46b"), 3.0)
	draw_rect(Rect2(p + Vector2(-10, 9), Vector2(20, 24)), Color("584432"))
	draw_rect(Rect2(p + Vector2(-28, -5), Vector2(12, 12)), Color("b6c9bd"))
	draw_rect(Rect2(p + Vector2(16, -5), Vector2(12, 12)), Color("b6c9bd"))
	draw_label(sign_text, p + Vector2(-35, 52), 13, Color("fff0c7"))

func draw_zone_boundaries(camera: Vector2) -> void:
	var boundary_color := Color("3f3628")
	var accent_color := Color("cbb68c")
	var thickness := 14.0
	var half_gap := ZONE_GATE_HALF_WIDTH
	# Forest to Desert / Haunted Jungle seams.
	for x_pos in [FOREST_START, FOREST_END]:
		var open_y: float = TOWN.y
		for seg in [
			[FOREST_START, open_y - half_gap],
			[open_y + half_gap, FOREST_END]
		]:
			var start: Vector2 = Vector2(x_pos, float(seg[0])) - camera
			var finish: Vector2 = Vector2(x_pos, float(seg[1])) - camera
			draw_line(start, finish, boundary_color, thickness)
			draw_line(start + Vector2(-4, 0), finish + Vector2(-4, 0), accent_color, 3.0)
	# Forest to Mountains / Volcano seams.
	for y_pos in [FOREST_START, FOREST_END]:
		var open_x: float = TOWN.x
		for seg in [
			[FOREST_START, open_x - half_gap],
			[open_x + half_gap, FOREST_END]
		]:
			var start: Vector2 = Vector2(float(seg[0]), y_pos) - camera
			var finish: Vector2 = Vector2(float(seg[1]), y_pos) - camera
			draw_line(start, finish, boundary_color, thickness)
			draw_line(start + Vector2(0, -4), finish + Vector2(0, -4), accent_color, 3.0)
	# Simple gate posts at the path crossings.
	for gate_point in [north_zone_gate(), east_zone_gate(), south_zone_gate(), west_zone_gate()]:
		var gate_screen: Vector2 = gate_point - camera
		draw_rect(Rect2(gate_screen - Vector2(10, 24), Vector2(20, 48)), Color("7d6a4b"))
		draw_rect(Rect2(gate_screen - Vector2(6, 18), Vector2(12, 36)), Color("c0ab84"))

func draw_sanctuary(camera: Vector2) -> void:
	var town_screen: Vector2 = TOWN - camera
	var top_left: Vector2 = TOWN - CASTLE_HALF - camera
	var size: Vector2 = CASTLE_HALF * 2.0
	# Large rectangular stone courtyard, framed by a visible stone curtain wall.
	draw_rect(Rect2(top_left, size), Color("7c6e5e"))
	draw_rect(Rect2(top_left + Vector2(24, 24), size - Vector2(48, 48)), Color("a6977c"))
	for xi in range(0, 33):
		for yi in range(0, 26):
			var cobble: Vector2 = top_left + Vector2(33.0 + float(xi) * 35.0 + (14.0 if yi % 2 == 0 else 0.0), 34.0 + float(yi) * 35.0)
			if cobble.x < top_left.x + size.x - 26.0 and cobble.y < top_left.y + size.y - 26.0:
				draw_rect(Rect2(cobble, Vector2(31, 30)), Color("b4a68b") if (xi + yi) % 4 != 0 else Color("968873"))
	# Cross-shaped main avenues now connect all four drawbridges.
	draw_rect(Rect2(town_screen + Vector2(-44, -470), Vector2(88, 940)), Color("c2b18e"))
	draw_rect(Rect2(town_screen + Vector2(-500, -33), Vector2(1000, 66)), Color("c2b18e"))
	# Stone castle keep in the northern part of the stronghold.
	draw_rect(Rect2(town_screen + Vector2(-118, -245), Vector2(236, 170)), Color("625e5c"))
	draw_rect(Rect2(town_screen + Vector2(-108, -235), Vector2(216, 150)), Color("aba18c"))
	draw_colored_polygon(PackedVector2Array([town_screen + Vector2(-132, -235), town_screen + Vector2(0, -317), town_screen + Vector2(132, -235)]), Color("834d43"))
	for off in [-90.0, 90.0]:
		var t: Vector2 = town_screen + Vector2(off, -231)
		draw_rect(Rect2(t - Vector2(22, 37), Vector2(44, 69)), Color("8c8a82"))
		draw_rect(Rect2(t - Vector2(25, 42), Vector2(50, 12)), Color("c4bca8"))
		draw_rect(Rect2(t - Vector2(6, 1), Vector2(12, 19)), Color("263747"))
	draw_rect(Rect2(town_screen + Vector2(-23, -125), Vector2(46, 41)), Color("5b4335"))
	draw_label("CASTLE KEEP", town_screen + Vector2(-68, -321), 17, Color("fff0c7"))
	draw_town_building(TOWN + Vector2(-270, -110), camera, Color("6b8069"), "ARMORY")
	draw_town_building(TOWN + Vector2(270, -110), camera, Color("857253"), "GENERAL STORE")
	draw_town_building(TOWN + Vector2(-270, 210), camera, Color("786a87"), "INN")
	draw_town_building(TOWN + Vector2(270, 210), camera, Color("6b8b85"), "STORAGE")
	draw_town_building(TOWN + Vector2(-250, 345), camera, Color("7a8665"), "MARKET")
	for offset in [Vector2(-84, -90), Vector2(84, -90), Vector2(-84, 120), Vector2(84, 120), Vector2(-84, 335), Vector2(84, 335)]:
		var l: Vector2 = town_screen + offset
		draw_rect(Rect2(l + Vector2(-2, -18), Vector2(4, 25)), Color("654b33"))
		draw_circle(l + Vector2(0, -19), 10.0, Color("ffda83", 0.20))
		draw_circle(l + Vector2(0, -19), 5.0, Color("ffe3a0"))
	var f: Vector2 = FOUNTAIN_POS - camera
	draw_circle(f, 44.0, Color("666e74"))
	draw_circle(f, 36.0, Color("a2cad5"))
	draw_circle(f, 28.0, Color("438ca9"))
	draw_circle(f, 13.0, Color("c5e7f2"))
	draw_circle(f, 6.0, Color.WHITE)
	draw_label("HEALING FOUNTAIN", f + Vector2(-80, 62), 14, Color("e6f8ff"))
	# Four gated openings in the curtain wall.
	var wall: float = CASTLE_WALL_THICKNESS
	var wall_color := Color("716c67")
	var wall_light := Color("bdb7a5")
	var border := Color("3e444b")
	var segments: Array = [
		Rect2(top_left + Vector2(0, 0), Vector2(size.x * 0.5 - CASTLE_GATE_HALF_WIDTH, wall)),
		Rect2(top_left + Vector2(size.x * 0.5 + CASTLE_GATE_HALF_WIDTH, 0), Vector2(size.x * 0.5 - CASTLE_GATE_HALF_WIDTH, wall)),
		Rect2(top_left + Vector2(0, size.y - wall), Vector2(size.x * 0.5 - CASTLE_GATE_HALF_WIDTH, wall)),
		Rect2(top_left + Vector2(size.x * 0.5 + CASTLE_GATE_HALF_WIDTH, size.y - wall), Vector2(size.x * 0.5 - CASTLE_GATE_HALF_WIDTH, wall)),
		Rect2(top_left + Vector2(0, 0), Vector2(wall, size.y * 0.5 - CASTLE_GATE_HALF_WIDTH)),
		Rect2(top_left + Vector2(0, size.y * 0.5 + CASTLE_GATE_HALF_WIDTH), Vector2(wall, size.y * 0.5 - CASTLE_GATE_HALF_WIDTH)),
		Rect2(top_left + Vector2(size.x - wall, 0), Vector2(wall, size.y * 0.5 - CASTLE_GATE_HALF_WIDTH)),
		Rect2(top_left + Vector2(size.x - wall, size.y * 0.5 + CASTLE_GATE_HALF_WIDTH), Vector2(wall, size.y * 0.5 - CASTLE_GATE_HALF_WIDTH))
	]
	for segment in segments:
		draw_rect(segment, wall_color)
		draw_rect(segment, border, false, 2.0)
		if segment.size.x > segment.size.y:
			draw_line(segment.position + Vector2(0, 5), segment.position + Vector2(segment.size.x, 5), wall_light, 3.0)
		else:
			draw_line(segment.position + Vector2(6, 0), segment.position + Vector2(6, segment.size.y), wall_light, 3.0)
	for i in range(0, 33):
		var xx: float = float(i) * 37.0
		if xx < size.x - 13.0 and absf(xx - size.x * 0.5) > CASTLE_GATE_HALF_WIDTH + 10.0:
			draw_rect(Rect2(top_left + Vector2(xx, -7), Vector2(18, 15)), wall_light)
			draw_rect(Rect2(top_left + Vector2(xx, size.y - 8), Vector2(18, 15)), wall_light)
	for i in range(0, 27):
		var yy: float = float(i) * 37.0
		if yy < size.y - 12.0 and absf(yy - size.y * 0.5) > CASTLE_GATE_HALF_WIDTH + 10.0:
			draw_rect(Rect2(top_left + Vector2(-7, yy), Vector2(15, 18)), wall_light)
			draw_rect(Rect2(top_left + Vector2(size.x - 8, yy), Vector2(15, 18)), wall_light)
	for off in [Vector2(-CASTLE_HALF.x, -CASTLE_HALF.y), Vector2(CASTLE_HALF.x, -CASTLE_HALF.y), Vector2(-CASTLE_HALF.x, CASTLE_HALF.y), Vector2(CASTLE_HALF.x, CASTLE_HALF.y)]:
		var tower: Vector2 = town_screen + off
		draw_rect(Rect2(tower - Vector2(33, 33), Vector2(66, 66)), border)
		draw_rect(Rect2(tower - Vector2(27, 27), Vector2(54, 54)), wall_light)
		draw_rect(Rect2(tower - Vector2(20, 20), Vector2(40, 40)), Color("765e61"))
		draw_rect(Rect2(tower - Vector2(10, 10), Vector2(20, 20)), Color("914c43"))
	# Gate towers and drawbridges on all four sides.
	for gate_center in [Vector2(0, -CASTLE_HALF.y), Vector2(CASTLE_HALF.x, 0), Vector2(0, CASTLE_HALF.y), Vector2(-CASTLE_HALF.x, 0)]:
		if gate_center.y != 0:
			for side in [-1.0, 1.0]:
				var tower_pos: Vector2 = town_screen + Vector2(gate_center) + Vector2(side * (CASTLE_GATE_HALF_WIDTH + 24.0), 0)
				draw_rect(Rect2(tower_pos - Vector2(34, 39), Vector2(68, 78)), border)
				draw_rect(Rect2(tower_pos - Vector2(28, 34), Vector2(56, 68)), Color("b6aa94"))
				draw_rect(Rect2(tower_pos - Vector2(19, 27), Vector2(38, 53)), Color("776e68"))
				draw_rect(Rect2(tower_pos - Vector2(12, -2), Vector2(24, 14)), Color("303a43"))
		else:
			for side in [-1.0, 1.0]:
				var tower_pos: Vector2 = town_screen + Vector2(gate_center) + Vector2(0, side * (CASTLE_GATE_HALF_WIDTH + 24.0))
				draw_rect(Rect2(tower_pos - Vector2(39, 34), Vector2(78, 68)), border)
				draw_rect(Rect2(tower_pos - Vector2(34, 28), Vector2(68, 56)), Color("b6aa94"))
				draw_rect(Rect2(tower_pos - Vector2(27, 19), Vector2(53, 38)), Color("776e68"))
				draw_rect(Rect2(tower_pos - Vector2(-2, 12), Vector2(14, 24)), Color("303a43"))
	# South and north drawbridges.
	var gate_width: float = CASTLE_GATE_HALF_WIDTH * 2.0
	for gate_y in [top_left.y, top_left.y + size.y]:
		var dir: float = -1.0 if gate_y == top_left.y else 1.0
		draw_rect(Rect2(Vector2(town_screen.x - 88.0, gate_y - 147.0 if dir < 0.0 else gate_y + 5.0), Vector2(176, 142)), Color("27576b"))
		draw_rect(Rect2(Vector2(town_screen.x - CASTLE_GATE_HALF_WIDTH + 8.0, gate_y - 147.0 if dir < 0.0 else gate_y - 28.0), Vector2(gate_width - 16.0, 175)), Color("65452e"))
		for k in range(0, 8):
			var plank_y: float = (gate_y - 147.0 if dir < 0.0 else gate_y - 26.0) + float(k) * 23.0
			draw_line(Vector2(town_screen.x - CASTLE_GATE_HALF_WIDTH + 10.0, plank_y), Vector2(town_screen.x + CASTLE_GATE_HALF_WIDTH - 10.0, plank_y), Color("c38c53"), 3.0)
	# West and east drawbridges.
	for gate_x in [top_left.x, top_left.x + size.x]:
		var dir_x: float = -1.0 if gate_x == top_left.x else 1.0
		draw_rect(Rect2(Vector2(gate_x - 147.0 if dir_x < 0.0 else gate_x + 5.0, town_screen.y - 88.0), Vector2(142, 176)), Color("27576b"))
		draw_rect(Rect2(Vector2(gate_x - 147.0 if dir_x < 0.0 else gate_x - 28.0, town_screen.y - CASTLE_GATE_HALF_WIDTH + 8.0), Vector2(175, gate_width - 16.0)), Color("65452e"))
		for k in range(0, 8):
			var plank_x: float = (gate_x - 147.0 if dir_x < 0.0 else gate_x - 26.0) + float(k) * 23.0
			draw_line(Vector2(plank_x, town_screen.y - CASTLE_GATE_HALF_WIDTH + 10.0), Vector2(plank_x, town_screen.y + CASTLE_GATE_HALF_WIDTH - 10.0), Color("c38c53"), 3.0)
	draw_line(top_left + Vector2(wall, wall), top_left + Vector2(size.x - wall, wall), Color("e3d39c", 0.5), 2.0)
	draw_label("NORTH DRAWBRIDGE", town_screen + Vector2(-104, -548), 16, Color("ffe9b2"))
	draw_label("EAST DRAWBRIDGE", town_screen + Vector2(470, -145), 16, Color("ffe9b2"))
	draw_label("SOUTH DRAWBRIDGE", town_screen + Vector2(-98, 684), 16, Color("ffe9b2"))
	draw_label("WEST DRAWBRIDGE", town_screen + Vector2(-594, -145), 16, Color("ffe9b2"))
	draw_label("SANCTUARY - CASTLE", town_screen + Vector2(-118, -395), 19, Color("fff4c8"))

func draw_wolf(center: Vector2, flashed: bool, direction: Vector2) -> void:
	# Shaggier side-profile wolf inspired by the user's latest reference.
	var facing_left: bool = direction.x < 0.0
	var frame: int = 0
	if direction.length_squared() > 0.01:
		frame = int(floor(lightning_clock * 6.0)) % 3
	var outline := Color("2b2016")
	var fur_dark := Color.WHITE if flashed else Color("8f6742")
	var fur_mid := Color.WHITE if flashed else Color("b18458")
	var fur_light := Color.WHITE if flashed else Color("d0b08a")
	var mane := Color.WHITE if flashed else Color("d8c09b")
	var muzzle := Color.WHITE if flashed else Color("eadfce")
	var eye := Color("f9f7f1")
	draw_set_transform(center, 0.0, Vector2(-1.0 if facing_left else 1.0, 1.0))
	# Tail
	draw_colored_polygon(PackedVector2Array([
		Vector2(-18, -2), Vector2(-29, -7), Vector2(-40, -9), Vector2(-49, -6), Vector2(-41, -1), Vector2(-28, 2), Vector2(-19, 1)
	]), outline)
	draw_colored_polygon(PackedVector2Array([
		Vector2(-20, -2), Vector2(-31, -6), Vector2(-41, -7), Vector2(-44, -5), Vector2(-38, -1), Vector2(-29, 2), Vector2(-21, 1)
	]), fur_light)
	# Body
	draw_colored_polygon(PackedVector2Array([
		Vector2(-19, 8), Vector2(-20, 0), Vector2(-16, -7), Vector2(-8, -10), Vector2(3, -11), Vector2(16, -10), Vector2(26, -6), Vector2(31, -1), Vector2(28, 8), Vector2(14, 12), Vector2(-4, 12)
	]), outline)
	draw_colored_polygon(PackedVector2Array([
		Vector2(-17, 7), Vector2(-17, 0), Vector2(-13, -6), Vector2(-6, -8), Vector2(4, -9), Vector2(15, -8), Vector2(23, -5), Vector2(27, -1), Vector2(24, 6), Vector2(12, 9), Vector2(-3, 10)
	]), fur_mid)
	draw_colored_polygon(PackedVector2Array([
		Vector2(-10, -5), Vector2(-2, -7), Vector2(10, -6), Vector2(18, -3), Vector2(17, 2), Vector2(6, 3), Vector2(-6, 2), Vector2(-11, 0)
	]), fur_dark)
	# Mane / chest ruff
	draw_colored_polygon(PackedVector2Array([
		Vector2(13, -9), Vector2(20, -15), Vector2(28, -13), Vector2(33, -7), Vector2(35, 2), Vector2(30, 10), Vector2(22, 18), Vector2(15, 15), Vector2(18, 7), Vector2(17, -1)
	]), mane)
	# Head and ears
	draw_colored_polygon(PackedVector2Array([
		Vector2(18, -9), Vector2(24, -16), Vector2(32, -22), Vector2(38, -20), Vector2(43, -14), Vector2(50, -11), Vector2(55, -6), Vector2(56, 2), Vector2(52, 7), Vector2(42, 8), Vector2(33, 5), Vector2(24, 0), Vector2(19, -3)
	]), outline)
	draw_colored_polygon(PackedVector2Array([
		Vector2(20, -8), Vector2(26, -14), Vector2(33, -18), Vector2(38, -17), Vector2(42, -12), Vector2(48, -9), Vector2(52, -5), Vector2(53, 1), Vector2(49, 5), Vector2(41, 6), Vector2(33, 4), Vector2(25, 0), Vector2(21, -2)
	]), fur_mid)
	draw_colored_polygon(PackedVector2Array([
		Vector2(31, -17), Vector2(34, -29), Vector2(40, -18)
	]), fur_dark)
	draw_colored_polygon(PackedVector2Array([
		Vector2(40, -16), Vector2(44, -28), Vector2(49, -15)
	]), fur_dark)
	draw_colored_polygon(PackedVector2Array([
		Vector2(41, -1), Vector2(54, 0), Vector2(55, 4), Vector2(42, 5), Vector2(39, 2)
	]), muzzle)
	draw_rect(Rect2(41, -10, 3, 3), eye)
	draw_rect(Rect2(53, 1, 3, 3), outline)
	# Collar-like rune mark for fantasy look.
	draw_arc(Vector2(18, 6), 5.0, 0.3, PI + 0.2, 14, Color("d6c07e"), 2.0)
	# Legs
	var leg_offsets := [0.0, 0.0, 0.0, 0.0]
	if frame == 1:
		leg_offsets = [2.0, -1.0, -1.0, 2.0]
	elif frame == 2:
		leg_offsets = [-1.0, 2.0, 2.0, -1.0]
	var leg_xs := [-10.0, -2.0, 13.0, 21.0]
	for i in range(4):
		var lx: float = leg_xs[i]
		var ly: float = 9.0 + float(leg_offsets[i])
		draw_rect(Rect2(lx - 2.0, ly, 4.0, 15.0), outline)
		draw_rect(Rect2(lx - 1.0, ly, 2.0, 11.0), fur_dark)
		draw_rect(Rect2(lx - 2.5, ly + 13.0, 5.0, 2.5), muzzle)
	# Belly line and reset transform
	draw_line(Vector2(-8, 9), Vector2(20, 8), fur_dark, 2.0)
	draw_set_transform(Vector2.ZERO)
func draw_castle_guard(center: Vector2, left_guard: bool, attack_flash: float) -> void:
	# Two armored sentries flanking the bridge, each with a polearm.
	var dark := Color("222b37")
	var silver := Color("bdc8d4")
	var blue := Color("30577d")
	draw_circle(center + Vector2(0, 13), 17.0, Color("29313b", 0.65))
	draw_rect(Rect2(center + Vector2(-12, -8), Vector2(24, 23)), dark)
	draw_rect(Rect2(center + Vector2(-10, -7), Vector2(20, 20)), silver)
	draw_rect(Rect2(center + Vector2(-11, 8), Vector2(22, 5)), blue)
	draw_rect(Rect2(center + Vector2(-9, 13), Vector2(7, 10)), dark)
	draw_rect(Rect2(center + Vector2(2, 13), Vector2(7, 10)), dark)
	draw_rect(Rect2(center + Vector2(-10, -24), Vector2(20, 19)), dark)
	draw_rect(Rect2(center + Vector2(-8, -22), Vector2(16, 15)), silver)
	draw_rect(Rect2(center + Vector2(-7, -14), Vector2(14, 3)), dark)
	draw_rect(Rect2(center + Vector2(-2, -15), Vector2(4, 9)), dark)
	var pole_x: float = -18.0 if left_guard else 18.0
	draw_line(center + Vector2(pole_x, 20), center + Vector2(pole_x, -37), Color("785437"), 4.0)
	draw_colored_polygon(PackedVector2Array([center + Vector2(pole_x - 6.0, -31), center + Vector2(pole_x, -53), center + Vector2(pole_x + 6.0, -31)]), Color("e5f2ff"))
	if attack_flash > 0.0:
		draw_arc(center, 33.0, PI * 0.15, PI * 1.5, 20, Color("f8e5a2", attack_flash * 3.6), 4.0)

func draw_bat(center: Vector2, flashed: bool) -> void:
	# Purple bat with pointy ears, outstretched wings and glowing eyes.
	var wing: Color = Color.WHITE if flashed else Color("7641a4")
	var body: Color = Color.WHITE if flashed else Color("b77bde")
	draw_colored_polygon(PackedVector2Array([center + Vector2(-6, 0), center + Vector2(-29, -13), center + Vector2(-24, 1), center + Vector2(-16, 6), center + Vector2(-11, 3), center + Vector2(-7, 12)]), wing)
	draw_colored_polygon(PackedVector2Array([center + Vector2(6, 0), center + Vector2(29, -13), center + Vector2(24, 1), center + Vector2(16, 6), center + Vector2(11, 3), center + Vector2(7, 12)]), wing)
	draw_colored_polygon(PackedVector2Array([center + Vector2(-11, -7), center + Vector2(-9, -19), center + Vector2(-1, -9)]), body)
	draw_colored_polygon(PackedVector2Array([center + Vector2(1, -9), center + Vector2(9, -19), center + Vector2(11, -7)]), body)
	draw_circle(center, 11.0, body)
	draw_rect(Rect2(center + Vector2(-6, -4), Vector2(4, 4)), Color("fff4b4"))
	draw_rect(Rect2(center + Vector2(2, -4), Vector2(4, 4)), Color("fff4b4"))

func draw_knight_barrier_orbit(center: Vector2) -> void:
	if knight_ability_timer <= 0.0:
		return
	var glow_alpha: float = 0.28 + 0.12 * sin(knight_ability_spin * 3.2)
	draw_arc(center, KNIGHT_ABILITY_RADIUS, 0.0, TAU, 48, Color(0.66, 0.92, 1.0, glow_alpha), 2.0)
	for i in range(3):
		var angle: float = knight_ability_spin + TAU * float(i) / 3.0
		var shield_pos: Vector2 = center + Vector2.RIGHT.rotated(angle) * KNIGHT_ABILITY_RADIUS
		draw_shield_symbol(shield_pos, 1.55, Color("8aaed4"), Color("f4fbff"))
		draw_circle(shield_pos, 25.0, Color(0.55, 0.88, 1.0, 0.08))

func draw_bladestorm_orbit(center: Vector2) -> void:
	if bladestorm_timer <= 0.0:
		return
	var alpha: float = clampf(bladestorm_timer / BLADESTORM_DURATION, 0.12, 1.0)
	draw_arc(center, KNIGHT_ABILITY_RADIUS, 0.0, TAU, 56, Color(0.91, 0.15, 0.20, 0.30 * alpha), 3.0)
	for i in range(3):
		var angle: float = bladestorm_spin + TAU * float(i) / 3.0
		var sword_pos: Vector2 = center + Vector2.RIGHT.rotated(angle) * KNIGHT_ABILITY_RADIUS
		var tangent: Vector2 = Vector2.RIGHT.rotated(angle + PI * 0.5)
		var normal: Vector2 = Vector2(-tangent.y, tangent.x)
		var tip: Vector2 = sword_pos + tangent * 34.0
		var hilt: Vector2 = sword_pos - tangent * 21.0
		var guard: Vector2 = sword_pos - tangent * 9.0
		draw_line(hilt, tip, Color(0.28, 0.035, 0.06, alpha), 12.0)
		draw_line(guard, tip, Color(0.93, 0.10, 0.14, alpha), 8.0)
		draw_line(guard + normal * 3.0, tip, Color(1.0, 0.43, 0.40, alpha), 2.5)
		draw_line(guard - normal * 13.0, guard + normal * 13.0, Color(0.75, 0.12, 0.14, alpha), 6.0)
		draw_line(hilt, guard, Color(0.38, 0.08, 0.10, alpha), 5.0)
		draw_circle(hilt, 5.0, Color(0.95, 0.24, 0.24, alpha))

func draw_cave_oval(center: Vector2, radii: Vector2, color: Color) -> void:
	# The Godot 4 CanvasItem API has no draw_ellipse() method.
	# Draw an ellipse through a smoothly tessellated polygon instead.
	var points: PackedVector2Array = PackedVector2Array()
	for step in range(48):
		var angle: float = TAU * float(step) / 48.0
		points.append(center + Vector2(cos(angle) * radii.x, sin(angle) * radii.y))
	draw_colored_polygon(points, color)

func draw_forest_cave_entrance(camera: Vector2) -> void:
	var p: Vector2 = FOREST_CAVE_POS - camera
	if p.x < -190.0 or p.x > VIEW.x + 190.0 or p.y < -210.0 or p.y > VIEW.y + 210.0:
		return
	# A more three-dimensional cave entrance carved into a rocky hillside.
	var cliff_dark := Color("41483f")
	var cliff_mid := Color("677064")
	var cliff_light := Color("8d9483")
	var moss := Color("52714d")
	# Back cliff / hill face.
	draw_colored_polygon(PackedVector2Array([
		p + Vector2(-150, 78), p + Vector2(-126, -15), p + Vector2(-98, -70), p + Vector2(-36, -112),
		p + Vector2(0, -126), p + Vector2(42, -116), p + Vector2(99, -79), p + Vector2(130, -17),
		p + Vector2(152, 78), p + Vector2(88, 126), p + Vector2(-89, 126)
	]), cliff_mid)
	# Side buttresses to create a tunnel-like opening.
	draw_colored_polygon(PackedVector2Array([p + Vector2(-142, 81), p + Vector2(-128, -8), p + Vector2(-89, -26), p + Vector2(-78, 63), p + Vector2(-95, 112)]), cliff_dark)
	draw_colored_polygon(PackedVector2Array([p + Vector2(142, 81), p + Vector2(128, -8), p + Vector2(89, -26), p + Vector2(78, 63), p + Vector2(95, 112)]), cliff_dark)
	# Front rocky arch lip.
	draw_colored_polygon(PackedVector2Array([
		p + Vector2(-98, 56), p + Vector2(-92, -8), p + Vector2(-70, -48), p + Vector2(-28, -80),
		p + Vector2(0, -90), p + Vector2(29, -80), p + Vector2(70, -48), p + Vector2(92, -8), p + Vector2(98, 56),
		p + Vector2(60, 70), p + Vector2(-61, 70)
	]), cliff_light)
	# Dark cave depth.
	draw_cave_oval(p + Vector2(0, 20), Vector2(70, 56), Color("16181d"))
	draw_cave_oval(p + Vector2(0, 12), Vector2(58, 45), Color("090b11"))
	draw_cave_oval(p + Vector2(0, 3), Vector2(48, 34), Color("040507"))
	# Ground shadow/ramp entering the cave.
	draw_colored_polygon(PackedVector2Array([p + Vector2(-72, 69), p + Vector2(72, 69), p + Vector2(100, 104), p + Vector2(-100, 104)]), Color("2c2f31", 0.60))
	# Scattered stones and moss.
	for stone in [Vector2(-108, 84), Vector2(-75, 95), Vector2(83, 91), Vector2(112, 80), Vector2(-121, 38), Vector2(123, 40)]:
		draw_circle(p + stone, 12.0, cliff_light)
	for tuft in [Vector2(-102, 57), Vector2(-83, -24), Vector2(80, -20), Vector2(98, 58), Vector2(0, -108)]:
		draw_circle(p + tuft, 11.0, moss)
	# The glowing portal sits recessed inside the cave, so it reads as a tunnel portal rather than a hole in the ground.
	var pulse: float = 0.78 + 0.22 * sin(lightning_clock * 4.0)
	draw_circle(p + Vector2(0, 6), 35.0, Color(0.28, 0.09, 0.58, 0.38))
	draw_arc(p + Vector2(0, 6), 31.0, 0.0, TAU, 48, Color(0.50, 0.84, 1.0, pulse), 5.0)
	draw_arc(p + Vector2(0, 6), 21.0, lightning_clock * 1.1, lightning_clock * 1.1 + TAU * 0.84, 32, Color("d7a1ff"), 4.0)
	draw_circle(p + Vector2(0, 6), 11.0, Color(0.74, 0.94, 1.0, pulse * 0.72))
	draw_label("BAT CAVE", p + Vector2(-45, -142), 18, Color("e8d5ff"))
	draw_label("ENTER PORTAL", p + Vector2(-63, 142), 14, Color("c8dfff"))

func draw_blood_bat(center: Vector2, flashed: bool) -> void:
	# Scaled by caller: black-violet silhouette, dark membranous wings, crimson eyes.
	var outline: Color = Color("100b1c") if not flashed else Color("f3ebff")
	var membrane: Color = Color("442655") if not flashed else Color("e6d3f5")
	var membrane_light: Color = Color("693977") if not flashed else Color.WHITE
	var fur: Color = Color("261e38") if not flashed else Color("f4edff")
	var fur_detail: Color = Color("60466b") if not flashed else Color.WHITE
	for side in [-1.0, 1.0]:
		var root: Vector2 = center + Vector2(side * 6.0, -2.0)
		var wing_tip: Vector2 = center + Vector2(side * 35.0, -19.0)
		var wing_low: Vector2 = center + Vector2(side * 32.0, 11.0)
		draw_colored_polygon(PackedVector2Array([root, center + Vector2(side * 24.0, -20.0), wing_tip, wing_low, center + Vector2(side * 20.0, 4.0), center + Vector2(side * 12.0, 13.0)]), outline)
		draw_colored_polygon(PackedVector2Array([root, center + Vector2(side * 23.0, -16.0), center + Vector2(side * 31.0, -14.0), center + Vector2(side * 27.0, 7.0), center + Vector2(side * 19.0, 1.0), center + Vector2(side * 12.0, 9.0)]), membrane)
		draw_line(root, wing_tip, membrane_light, 1.4)
		draw_line(root, wing_low, membrane_light, 1.0)
		draw_colored_polygon(PackedVector2Array([center + Vector2(side * 6.0, -8.0), center + Vector2(side * 13.0, -22.0), center + Vector2(side * 18.0, -7.0)]), outline)
		draw_line(center + Vector2(side * 7.0, 9.0), center + Vector2(side * 13.0, 18.0), fur_detail, 3.0)
		draw_line(center + Vector2(side * 13.0, 18.0), center + Vector2(side * 18.0, 21.0), Color("ccc1d2"), 1.4)
	draw_circle(center + Vector2(0, 2), 13.0, outline)
	draw_circle(center + Vector2(0, 1), 10.8, fur)
	for i in range(5):
		var xx: float = (float(i) - 2.0) * 4.0
		draw_colored_polygon(PackedVector2Array([center + Vector2(xx - 3.0, -3.0), center + Vector2(xx, -13.0 - float(i % 2) * 2.0), center + Vector2(xx + 3.0, -3.0)]), fur_detail)
	for side in [-1.0, 1.0]:
		draw_circle(center + Vector2(side * 4.7, -1.3), 2.8, Color("ce345a"))
		draw_circle(center + Vector2(side * 4.7, -1.3), 1.2, Color("ffc0d2"))
	draw_colored_polygon(PackedVector2Array([center + Vector2(-5, 5), center + Vector2(0, 12), center + Vector2(5, 5)]), Color("4b162b"))
	draw_line(center + Vector2(-3, 7), center + Vector2(-2, 10), Color("ece5ee"), 1.3)
	draw_line(center + Vector2(3, 7), center + Vector2(2, 10), Color("ece5ee"), 1.3)

func draw_morvex(center: Vector2, flashed: bool) -> void:
	# Higher-detail in-game Morvex sprite built from layered geometry.
	var outline: Color = Color("130914")
	var wing_dark: Color = Color("2d1236") if not flashed else Color("d8d0e8")
	var wing_main: Color = Color("512365") if not flashed else Color("f1ebff")
	var wing_membrane: Color = Color("7d2d6a") if not flashed else Color("fff4ff")
	var fur_dark: Color = Color("251323") if not flashed else Color("ddd7ea")
	var fur_main: Color = Color("3d2247") if not flashed else Color("efe8fb")
	var fur_high: Color = Color("6b4c83") if not flashed else Color.WHITE
	var claw: Color = Color("d9d2dd")
	var mouth: Color = Color("56111e") if not flashed else Color("c84c6e")
	var eye: Color = Color("f05cff")
	var blood_rune: Color = Color("d21c43") if not flashed else Color("ff89ab")
	var hover: float = sin(lightning_clock * 2.8) * 3.0
	var c: Vector2 = center + Vector2(0.0, hover)
	# Shadow and aura.
	draw_circle(c + Vector2(0, 77), 96.0, Color(0, 0, 0, 0.22))
	draw_circle(c, 104.0, Color(0.62, 0.15, 0.35, 0.08))
	for side in [-1.0, 1.0]:
		# Outer wing silhouette.
		var shoulder: Vector2 = c + Vector2(side * 44.0, -12.0)
		var elbow: Vector2 = c + Vector2(side * 118.0, -56.0)
		var mid: Vector2 = c + Vector2(side * 171.0, -14.0)
		var tip: Vector2 = c + Vector2(side * 212.0, -84.0)
		var lower_tip: Vector2 = c + Vector2(side * 203.0, 47.0)
		var fold_a: Vector2 = c + Vector2(side * 142.0, 66.0)
		var fold_b: Vector2 = c + Vector2(side * 95.0, 48.0)
		var inner_root: Vector2 = c + Vector2(side * 47.0, 33.0)
		draw_colored_polygon(PackedVector2Array([shoulder, elbow, tip, mid, lower_tip, fold_a, fold_b, inner_root]), outline)
		draw_colored_polygon(PackedVector2Array([
			shoulder + Vector2(side * 2.0, 1.0),
			elbow + Vector2(side * -5.0, 7.0),
			tip + Vector2(side * -10.0, 9.0),
			mid + Vector2(side * -9.0, 11.0),
			lower_tip + Vector2(side * -11.0, -14.0),
			fold_a + Vector2(side * -5.0, -11.0),
			fold_b + Vector2(side * -3.0, -10.0),
			inner_root + Vector2(side * 0.0, -7.0)
		]), wing_main)
		# Inner membrane and wing fingers.
		draw_colored_polygon(PackedVector2Array([
			shoulder + Vector2(side * 8.0, 8.0),
			elbow + Vector2(side * -11.0, 10.0),
			tip + Vector2(side * -22.0, 17.0),
			mid + Vector2(side * -22.0, 24.0),
			lower_tip + Vector2(side * -18.0, -20.0),
			fold_a + Vector2(side * -10.0, -18.0),
			fold_b + Vector2(side * -8.0, -17.0),
			inner_root + Vector2(side * 5.0, -8.0)
		]), wing_membrane)
		for joint in [elbow, mid, lower_tip, fold_a, fold_b]:
			draw_line(shoulder, joint, fur_high, 3.0 if joint == elbow else 2.0)
		# Upper wing horn and forelimb claws.
		draw_colored_polygon(PackedVector2Array([c + Vector2(side * 36.0, -39.0), c + Vector2(side * 68.0, -109.0), c + Vector2(side * 81.0, -33.0)]), outline)
		draw_colored_polygon(PackedVector2Array([c + Vector2(side * 44.0, -46.0), c + Vector2(side * 66.0, -88.0), c + Vector2(side * 72.0, -36.0)]), wing_dark)
		draw_line(c + Vector2(side * 42.0, 29.0), c + Vector2(side * 74.0, 73.0), fur_high, 14.0)
		for claw_index in [-1.0, 0.0, 1.0]:
			draw_line(c + Vector2(side * 74.0, 73.0), c + Vector2(side * (86.0 + claw_index * 13.0), 93.0), claw, 3.5)
	# Body and ruff.
	draw_circle(c + Vector2(0, 17), 74.0, outline)
	draw_circle(c + Vector2(0, 15), 68.0, fur_dark)
	draw_circle(c + Vector2(0, 10), 60.0, fur_main)
	for i in range(9):
		var x: float = (float(i) - 4.0) * 13.0
		var y_variation: float = -58.0 - 7.0 * sin(float(i) * 0.8 + lightning_clock * 1.5)
		draw_colored_polygon(PackedVector2Array([c + Vector2(x - 10.0, -34.0), c + Vector2(x, y_variation), c + Vector2(x + 10.0, -34.0)]), fur_high)
	# Chest hair layers.
	for tuft in [Vector2(-22, 43), Vector2(0, 54), Vector2(22, 43), Vector2(-12, 61), Vector2(12, 61)]:
		draw_colored_polygon(PackedVector2Array([c + tuft + Vector2(-10, -7), c + tuft + Vector2(0, 18), c + tuft + Vector2(10, -7)]), fur_high)
	# Head, ears, face and jaw.
	draw_circle(c + Vector2(0, -5), 42.0, outline)
	draw_circle(c + Vector2(0, -6), 37.0, fur_main)
	for side in [-1.0, 1.0]:
		draw_colored_polygon(PackedVector2Array([c + Vector2(side * 20.0, -28.0), c + Vector2(side * 44.0, -84.0), c + Vector2(side * 57.0, -17.0)]), outline)
		draw_colored_polygon(PackedVector2Array([c + Vector2(side * 24.0, -32.0), c + Vector2(side * 41.0, -67.0), c + Vector2(side * 48.0, -21.0)]), wing_dark)
		draw_colored_polygon(PackedVector2Array([c + Vector2(side * 28.0, -30.0), c + Vector2(side * 39.0, -54.0), c + Vector2(side * 43.0, -24.0)]), wing_membrane)
	# Snout and mouth.
	draw_colored_polygon(PackedVector2Array([c + Vector2(-26, 8), c + Vector2(0, 30), c + Vector2(27, 8), c + Vector2(16, -2), c + Vector2(-16, -2)]), outline)
	draw_colored_polygon(PackedVector2Array([c + Vector2(-21, 9), c + Vector2(0, 26), c + Vector2(22, 9), c + Vector2(12, 1), c + Vector2(-12, 1)]), mouth)
	for tooth_x in [-16.0, -5.0, 5.0, 16.0]:
		draw_colored_polygon(PackedVector2Array([c + Vector2(tooth_x - 3.0, 10.0), c + Vector2(tooth_x, 25.0), c + Vector2(tooth_x + 3.0, 10.0)]), claw)
	# Eyes and brow.
	for side in [-1.0, 1.0]:
		draw_colored_polygon(PackedVector2Array([c + Vector2(side * 6.0, -11.0), c + Vector2(side * 28.0, -18.0), c + Vector2(side * 23.0, -4.0)]), outline)
		draw_circle(c + Vector2(side * 18.0, -4.0), 12.0, Color(0.92, 0.20, 0.64, 0.22))
		draw_circle(c + Vector2(side * 18.0, -4.0), 8.0, eye)
		draw_circle(c + Vector2(side * 18.0, -4.0), 3.0, Color("fff8ff"))
	# Blood echo rune on forehead.
	draw_colored_polygon(PackedVector2Array([c + Vector2(0, -38), c + Vector2(10, -28), c + Vector2(0, -18), c + Vector2(-10, -28)]), blood_rune)
	draw_circle(c + Vector2(0, -28), 3.0, Color("ffd2dc"))
	# Small hanging tail silhouette.
	draw_line(c + Vector2(0, 73), c + Vector2(0, 102), fur_high, 6.0)
	draw_colored_polygon(PackedVector2Array([c + Vector2(-8, 100), c + Vector2(0, 121), c + Vector2(8, 100)]), wing_dark)

func draw_bat_cave_dungeon(camera: Vector2) -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color("090b13"))
	var x0: int = maxi(0, int(floor(camera.x / DUNGEON_TILE)) - 1)
	var x1: int = mini(DUNGEON_COLS - 1, int(ceil((camera.x + VIEW.x) / DUNGEON_TILE)) + 1)
	var y0: int = maxi(0, int(floor(camera.y / DUNGEON_TILE)) - 1)
	var y1: int = mini(DUNGEON_ROWS - 1, int(ceil((camera.y + VIEW.y) / DUNGEON_TILE)) + 1)
	for y in range(y0, y1 + 1):
		for x in range(x0, x1 + 1):
			var xy: Vector2 = Vector2(float(x), float(y)) * DUNGEON_TILE - camera
			var cell: Vector2i = Vector2i(x, y)
			if dungeon_walkable.has(cell):
				var floor_tint: Color = Color("41404b") if (x * 7 + y * 13) % 4 == 0 else Color("33343f")
				draw_rect(Rect2(xy, Vector2(DUNGEON_TILE, DUNGEON_TILE)), floor_tint)
				draw_line(xy + Vector2(8, 45), xy + Vector2(28, 51), Color("55535d", 0.43), 2.0)
				if (x * 11 + y * 17) % 19 == 1:
					draw_circle(xy + Vector2(48, 22), 7, Color("685c74"))
			else:
				draw_rect(Rect2(xy, Vector2(DUNGEON_TILE, DUNGEON_TILE)), Color("1a1c26"))
				draw_rect(Rect2(xy + Vector2(2, 3), Vector2(58, 55)), Color("272833"))
				draw_colored_polygon(PackedVector2Array([xy + Vector2(1, 1), xy + Vector2(34, 13), xy + Vector2(61, 3), xy + Vector2(55, 24), xy + Vector2(15, 34)]), Color("393b49"))
				if (x * 5 + y * 11) % 7 == 2:
					draw_colored_polygon(PackedVector2Array([xy + Vector2(10, 8), xy + Vector2(28, 38), xy + Vector2(40, 11)]), Color("535464"))
	# Cave lantern-like luminous crystals and bat roost shapes.
	for pt in [Vector2(8, 22), Vector2(5, 14), Vector2(17, 10), Vector2(23, 6), Vector2(31, 8)]:
		var crystal: Vector2 = pt * DUNGEON_TILE - camera
		draw_circle(crystal, 18, Color(0.3, 0.34, 0.8, 0.20))
		draw_colored_polygon(PackedVector2Array([crystal + Vector2(0, -19), crystal + Vector2(9, -3), crystal + Vector2(0, 8), crystal + Vector2(-8, -4)]), Color("9878df"))
	# Return portal beside the dungeon entrance.
	var exit_screen: Vector2 = DUNGEON_EXIT - camera
	draw_circle(exit_screen, 28, Color("233a63"))
	draw_arc(exit_screen, 25, 0, TAU, 40, Color("7edbff"), 5.0)
	draw_circle(exit_screen, 12, Color("b0f1ff"))
	draw_label("EXIT TO FOREST", exit_screen + Vector2(-63, 50), 14, Color("d0edff"))
	# Final chamber rune circle. Morvex is rendered with other enemies above it.
	var arena: Vector2 = DUNGEON_BOSS_CENTER - camera
	draw_arc(arena, 230.0, 0.0, TAU, 80, Color(0.62, 0.31, 0.71, 0.45), 3.0)
	if morvex_windup_timer > 0.0 and morvex_attack_telegraph >= 0:
		# Telegraph alternates with the current attack pattern.
		var warning_alpha: float = 0.35 + 0.30 * absf(sin(lightning_clock * 13.0))
		var lane_count: int = morvex_lane_count()
		var angle_offset: float = 0.0 if morvex_attack_style == 0 else PI / float(lane_count)
		for lane in range(lane_count):
			if is_morvex_wave_lane_gap(lane, morvex_attack_telegraph, morvex_attack_style):
				continue
			var angle: float = angle_offset + TAU * float(lane) / float(lane_count)
			var direction: Vector2 = Vector2.RIGHT.rotated(angle)
			var width: float = 8.0 if morvex_attack_style == 0 else 11.0
			var far_distance: float = 395.0 if morvex_attack_style == 0 else 425.0
			draw_line(arena, arena + direction * far_distance, Color(1.0, 0.23, 0.25, warning_alpha), width)
			if morvex_attack_style == 1:
				draw_line(arena + direction * 118.0, arena + direction * (far_distance - 40.0), Color(1.0, 0.62, 0.62, warning_alpha * 0.55), 4.0)
	if morvex_defeated:
		draw_label("MORVEX HAS FALLEN", arena + Vector2(-106, 135), 20, Color("e7b5ce"))

func draw_character_selection_preview(offset: Vector2) -> void:
	var selected: int = clampi(preview_slot, 0, CLASSES.size() - 1)
	var equip: Dictionary = slots[selected]["equipment"]
	var panel: Rect2 = CHARACTER_PREVIEW_PANEL
	draw_rect(panel, Color("18263a"))
	draw_rect(panel, COLORS[selected], false, 2.4)
	draw_label("CHARACTER PREVIEW", panel.position + Vector2(67, 29), 19, Color("e7eef5"))
	draw_label("%s  |  LEVEL %d" % [CLASSES[selected].to_upper(), int(slots[selected]["level"])], panel.position + Vector2(64, 59), 17, COLORS[selected])
	# Slight floor shadow helps the upright character read as standing, not lying flat.
	draw_circle(panel.position + Vector2(168, 204), 37, Color(0.03, 0.05, 0.10, 0.45))

	# Render the very same model used during gameplay, and temporarily provide
	# the selected character's equipment. There is no cached/static portrait.
	var previous_active: int = active_slot
	var previous_facing: Vector2 = facing_direction
	active_slot = selected
	facing_direction = Vector2.DOWN
	var preview_center: Vector2 = panel.position + Vector2(168, 188)
	draw_set_transform(offset + preview_center, 0.0, Vector2(2.05, 2.05))
	if selected == 0:
		draw_warrior_player(Vector2.ZERO)
	else:
		draw_default_player(Vector2.ZERO)
	draw_set_transform(offset)
	active_slot = previous_active
	facing_direction = previous_facing

	# Current saved equipment changes this preview each time the class is selected.
	var weapon_id: String = str(equip.get("weapon", ""))
	var offhand_id: String = str(equip.get("offhand", ""))
	var cosmetic_id: String = str(equip.get("cosmetic", ""))
	var weapon_name: String = str(ITEM_DATA[weapon_id]["name"]) if ITEM_DATA.has(weapon_id) else "None"
	var offhand_name: String = str(ITEM_DATA[offhand_id]["name"]) if ITEM_DATA.has(offhand_id) else "None"
	var cosmetic_name: String = str(ITEM_DATA[cosmetic_id]["name"]) if ITEM_DATA.has(cosmetic_id) else "None"
	var font: Font = ThemeDB.fallback_font
	draw_string(font, panel.position + Vector2(18, 239), "Weapon: " + weapon_name, HORIZONTAL_ALIGNMENT_LEFT, 306, 14, Color("ebecf4"))
	draw_string(font, panel.position + Vector2(18, 259), "Offhand: " + offhand_name, HORIZONTAL_ALIGNMENT_LEFT, 306, 14, Color("d6dce8"))
	draw_string(font, panel.position + Vector2(18, 280), "Cosmetic: " + cosmetic_name, HORIZONTAL_ALIGNMENT_LEFT, 306, 14, Color("d6dce8"))

func draw_character_selection_menu() -> void:
	var offset: Vector2 = (VIEW - DESIGN_VIEW) * 0.5
	draw_set_transform(offset)
	draw_label("EMBERWILD", Vector2(365, 67), 38, Color("f5d48c"))
	draw_label("Select a character to preview, then PLAY", Vector2(304, 111), 17, Color("b9c9d9"))
	for i in range(CLASSES.size()):
		var rect: Rect2 = Rect2(CHARACTER_SELECT_ORIGIN + Vector2(0, float(i) * CHARACTER_SELECT_STEP), CHARACTER_SELECT_ROW_SIZE)
		var is_selected: bool = i == preview_slot
		draw_rect(rect, Color("2b4258") if is_selected else Color("202d46"))
		draw_rect(rect, Color("ffe5ac") if is_selected else COLORS[i], false, 3.0 if is_selected else 2.0)
		draw_rect(Rect2(rect.position + Vector2(12, 13), Vector2(25, 31)), COLORS[i])
		draw_label(str(CLASSES[i]), rect.position + Vector2(49, 33), 21)
		draw_label("Lv %d   Gold %d" % [int(slots[i]["level"]), int(slots[i]["gold"])], rect.position + Vector2(235, 33), 14, Color("d5ddec"))
		var reset_rect: Rect2 = Rect2(457, 154 + float(i) * CHARACTER_SELECT_STEP, 104, 43)
		draw_rect(reset_rect, Color("66363b"))
		draw_rect(reset_rect, Color("e49b9b"), false, 2.0)
		draw_label("RESET", reset_rect.position + Vector2(23, 28), 17, Color("ffe8e8"))
	draw_character_selection_preview(offset)
	draw_rect(CHARACTER_PLAY_BUTTON, Color("326a51"))
	draw_rect(CHARACTER_PLAY_BUTTON, Color("a4f4c6"), false, 3.0)
	draw_label("PLAY " + str(CLASSES[preview_slot]).to_upper(), CHARACTER_PLAY_BUTTON.position + Vector2(29, 36), 22, Color("f5fff1"))
	draw_label("Tap a class / keys 1-5; Enter to play", Vector2(128, 518), 15, Color("b8c7db"))
	if reset_slot_pending != -1:
		# Modal drawn last, to sit over the character preview and class rows.
		draw_rect(Rect2(228, 198, 505, 201), Color("11192b"))
		draw_rect(Rect2(228, 198, 505, 201), Color("f3c28c"), false, 3.0)
		draw_label("RESET %s?" % CLASSES[reset_slot_pending].to_upper(), Vector2(342, 242), 25, Color("fff2c7"))
		draw_label("Erase level, gold, kills and equipment?", Vector2(279, 280), 17)
		draw_label("This cannot be undone!", Vector2(357, 305), 16, Color("f5a5a5"))
		draw_rect(RESET_CONFIRM_RECT, Color("923a43"))
		draw_rect(RESET_CANCEL_RECT, Color("3e6470"))
		draw_label("RESET", Vector2(361, 347), 19)
		draw_label("CANCEL", Vector2(526, 347), 19)
	draw_set_transform(Vector2.ZERO)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color("0b1020"))
	if active_slot < 0:
		draw_character_selection_menu()
		return
	var camera := player - VIEW * 0.5
	if dungeon_active:
		draw_bat_cave_dungeon(camera)
	else:
		var start_x := maxi(0, int(floor(camera.x / WORLD_TILE_SIZE)) - 1)
		var end_x := mini(int(ceil(WORLD_SIZE / WORLD_TILE_SIZE)), int(ceil((camera.x + VIEW.x) / WORLD_TILE_SIZE)) + 1)
		var start_y := maxi(0, int(floor(camera.y / WORLD_TILE_SIZE)) - 1)
		var end_y := mini(int(ceil(WORLD_SIZE / WORLD_TILE_SIZE)), int(ceil((camera.y + VIEW.y) / WORLD_TILE_SIZE)) + 1)
		for x in range(start_x, end_x + 1):
			for y in range(start_y, end_y + 1):
				var tile_world: Vector2 = Vector2(float(x) * WORLD_TILE_SIZE, float(y) * WORLD_TILE_SIZE)
				var region: int = zone_id_at(tile_world + Vector2(32.0, 32.0))
				if region < 0:
					continue
				var tile_screen: Vector2 = tile_world - camera
				var odd: int = (x * 17 + y * 31) % 7
				var on_road: bool = is_on_wilderness_road(tile_world + Vector2(32, 32))
				var tint: Color = terrain_color(region, odd, on_road)
				if is_in_sanctuary(tile_world):
					tint = Color("8c7856") if odd < 4 else Color("9b8560")
				draw_rect(Rect2(tile_screen, Vector2(WORLD_TILE_SIZE, WORLD_TILE_SIZE)), tint)
				if is_in_sanctuary(tile_world):
					if odd == 0:
						draw_rect(Rect2(tile_screen + Vector2(13, 16), Vector2(5, 5)), Color("65945c"))
				elif region >= 0:
					draw_biome_detail(tile_screen, x, y, region, on_road)
		# Labeled road destinations. Signs appear in the Forest near its four edges.
		var sign_sites: Array = [
			{"point": Vector2(FOREST_END - 170.0, TOWN.y - 64.0), "text": "DESERT  E"},
			{"point": Vector2(FOREST_START + 175.0, TOWN.y - 64.0), "text": "W  HAUNTED JUNGLE"},
			{"point": Vector2(TOWN.x - 88.0, FOREST_START + 155.0), "text": "N  MOUNTAINS"},
			{"point": Vector2(TOWN.x - 82.0, FOREST_END - 145.0), "text": "VOLCANO  S"}
		]
		for sign in sign_sites:
			var sign_pos: Vector2 = Vector2(sign["point"]) - camera
			if sign_pos.x > -160.0 and sign_pos.x < VIEW.x + 50.0 and sign_pos.y > -60.0 and sign_pos.y < VIEW.y + 40.0:
				draw_rect(Rect2(sign_pos + Vector2(-5, -9), Vector2(12, 42)), Color("55402f"))
				draw_rect(Rect2(sign_pos + Vector2(-54, -28), Vector2(117, 25)), Color("88613b"))
				draw_string(ThemeDB.fallback_font, sign_pos + Vector2(-48, -10), str(sign["text"]), HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color("fff0d1"))
		draw_zone_boundaries(camera)
		draw_sanctuary(camera)
		draw_forest_cave_entrance(camera)
		# Castle guards defend the drawbridge but never award player rewards.
		for guard_index in range(GUARD_POSITIONS.size()):
			var guard_screen: Vector2 = TOWN + GUARD_POSITIONS[guard_index] - camera
			draw_castle_guard(guard_screen, guard_index % 2 == 0, float(guard_attack_flash[guard_index]))
		# Royal merchant in the protected castle courtyard.
		var shop_npc: Vector2 = SWORD_MERCHANT_POS - camera
		draw_circle(shop_npc + Vector2(0, 14), 18.0, Color("332c29"))
		draw_rect(Rect2(shop_npc + Vector2(-12, -11), Vector2(24, 29)), Color("3b6387"))
		draw_rect(Rect2(shop_npc + Vector2(-10, -27), Vector2(20, 17)), Color("e4bd91"))
		draw_rect(Rect2(shop_npc + Vector2(-14, -30), Vector2(28, 7)), Color("b99b54"))
		draw_label("SWORD MERCHANT", shop_npc + Vector2(-68, -41), 15, Color("f9e3a8"))
		# Banker NPC: secure storage of gold and backpack items.
		var banker_screen: Vector2 = BANKER_POS - camera
		draw_circle(banker_screen + Vector2(0, 13), 18.0, Color("29292b"))
		draw_rect(Rect2(banker_screen + Vector2(-13, -11), Vector2(26, 31)), Color("3b7f61"))
		draw_rect(Rect2(banker_screen + Vector2(-10, -28), Vector2(20, 18)), Color("d8b58f"))
		draw_rect(Rect2(banker_screen + Vector2(-14, -30), Vector2(28, 7)), Color("cfb66e"))
		draw_label("BANKER", banker_screen + Vector2(-36, -43), 18, Color("d8ffc9"))
		# Oracle: robed seer near Sanctuary's healing fountain.
		var oracle_screen: Vector2 = ORACLE_POS - camera
		draw_circle(oracle_screen + Vector2(0, 17), 20.0, Color("312c47"))
		draw_colored_polygon(PackedVector2Array([oracle_screen + Vector2(-15, -10), oracle_screen + Vector2(15, -10), oracle_screen + Vector2(21, 22), oracle_screen + Vector2(-21, 22)]), Color("53468a"))
		draw_colored_polygon(PackedVector2Array([oracle_screen + Vector2(-15, -9), oracle_screen + Vector2(0, -39), oracle_screen + Vector2(15, -9)]), Color("7d6fb8"))
		draw_circle(oracle_screen + Vector2(0, -17), 10.0, Color("d9b99e"))
		draw_circle(oracle_screen + Vector2(-4, -18), 1.8, Color("c6ecff"))
		draw_circle(oracle_screen + Vector2(4, -18), 1.8, Color("c6ecff"))
		draw_circle(oracle_screen + Vector2(17, -3), 5.0, Color("bcb4ff"))
		draw_label("ORACLE", oracle_screen + Vector2(-38, -49), 18, Color("d5c6ff"))
	draw_bloody_footprints(camera)
	for loot in drops:
		var q: Vector2 = loot["pos"] - camera
		if loot.has("item"):
			var dropped_id: String = str(loot["item"])
			draw_ground_item_icon(dropped_id, q)
		elif loot.has("elixer"):
			var elixer_id: String = str(loot["elixer"])
			var glow_tint: Color = Color(str(ITEM_DATA[elixer_id]["color"]))
			glow_tint.a = 0.20
			draw_circle(q, 16.0, glow_tint)
			draw_item_icon(elixer_id, q, 0.65)
		elif bool(loot.get("potion", false)):
			draw_rect(Rect2(q + Vector2(-5, -9), Vector2(10, 5)), Color("f1e3c5"))
			draw_rect(Rect2(q + Vector2(-8, -4), Vector2(16, 16)), Color("f0dcdd"))
			draw_rect(Rect2(q + Vector2(-6, -1), Vector2(12, 11)), Color("cf3455"))
		else:
			draw_circle(q, 7.0, Color("ffd05c"))
	for enemy in enemies:
		var q: Vector2 = enemy["pos"] - camera
		var flashed: bool = float(enemy.get("hit_flash", 0.0)) > 0.0
		if int(enemy["type"]) == 0:
			draw_wolf(q, flashed, Vector2(enemy.get("facing", Vector2.DOWN)))
		elif int(enemy["type"]) == 2:
			draw_morvex(q, flashed)
		else:
			if dungeon_active and bool(enemy.get("dungeon", false)):
				# Draw a larger local bat while preserving its original coordinate.
				draw_set_transform(q, 0.0, Vector2(CAVE_BAT_SCALE, CAVE_BAT_SCALE))
				draw_blood_bat(Vector2.ZERO, flashed)
				draw_set_transform(Vector2.ZERO)
			else:
				draw_bat(q, flashed)
		# Names and numeric HP appear beneath/above monsters.
		var base_name: String = "Morvex, the Blood Echo" if int(enemy["type"]) == 2 else ("Wolf" if int(enemy["type"]) == 0 else ("Blood Bat" if bool(enemy.get("dungeon", false)) else "Bat"))
		var monster_level: int = int(enemy.get("level", WOLF_LEVEL if int(enemy["type"]) == 0 else BAT_LEVEL))
		var monster_name: String = "%s Lv. %d" % [base_name, monster_level]
		var hp_now: int = maxi(0, int(ceil(float(enemy["hp"]))))
		var hp_total: int = maxi(1, int(ceil(float(enemy["max_hp"]))))
		var health_label: String = "%d / %d HP" % [hp_now, hp_total]
		var health_font: Font = ThemeDB.fallback_font
		if int(enemy["type"]) != 2:
			var hp_y: float = -57.0 if dungeon_active and int(enemy["type"]) == 1 else -44.0
			var bar_y: float = -50.0 if dungeon_active and int(enemy["type"]) == 1 else -37.0
			var name_y: float = 56.0 if dungeon_active and int(enemy["type"]) == 1 else 40.0
			var hp_width: float = health_font.get_string_size(health_label, HORIZONTAL_ALIGNMENT_LEFT, -1, 13).x
			draw_string(health_font, q + Vector2(-hp_width * 0.5, hp_y), health_label, HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("ffffff"))
			draw_rect(Rect2(q + Vector2(-28, bar_y), Vector2(56, 6)), Color("302b35"))
			draw_rect(Rect2(q + Vector2(-28, bar_y), Vector2(56.0 * clampf(float(enemy["hp"]) / float(enemy["max_hp"]), 0.0, 1.0), 6)), Color("e8696d"))
			var name_width: float = health_font.get_string_size(monster_name, HORIZONTAL_ALIGNMENT_LEFT, -1, 16).x
			draw_string(health_font, q + Vector2(-name_width * 0.5, name_y), monster_name, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color("f5e9d6"))
	for bolt in enemy_projectiles:
		var bolt_pos: Vector2 = Vector2(bolt["pos"]) - camera
		if bool(bolt.get("sonic", false)):
			var tangent: Vector2 = Vector2(bolt["velocity"]).normalized().rotated(PI * 0.5)
			var thick: bool = bool(bolt.get("thick", false))
			var outer: float = 22.0 if thick else 16.0
			var inner: float = 17.0 if thick else 12.0
			var outer_width: float = 10.0 if thick else 8.0
			draw_line(bolt_pos - tangent * outer, bolt_pos + tangent * outer, Color("ef2d3b"), outer_width)
			draw_line(bolt_pos - tangent * inner, bolt_pos + tangent * inner, Color("ff9c9c"), 3.0)
			draw_circle(bolt_pos, 4.0 if thick else 3.0, Color("ffd0d0"))
		else:
			draw_circle(bolt_pos, 5.0, Color("be93ef"))
			draw_circle(bolt_pos, 2.0, Color("f3dcff"))
	for shot in projectiles:
		var shot_screen: Vector2 = shot["pos"] - camera
		if bool(shot.get("lightning", false)):
			# The bolt writhes on every frame, flashing electric blue and branching.
			var direction: Vector2 = Vector2(shot["velocity"]).normalized()
			var normal: Vector2 = Vector2(-direction.y, direction.x)
			var age: float = float(shot.get("age", 0.0))
			var seed_value: float = float(shot.get("seed", 0.0))
			var phase: float = age * 49.0 + lightning_clock * 13.0 + seed_value
			var points: PackedVector2Array = PackedVector2Array()
			for j in range(11):
				var t: float = float(j) / 10.0
				var sway: float = sin(t * 29.0 + phase) * 7.0 + sin(t * 57.0 - phase * 1.7) * 3.5
				if j == 0 or j == 10:
					sway = 0.0
				points.append(shot_screen + direction * lerpf(-30.0, 30.0, t) + normal * sway)
			var pulse: float = 0.65 + 0.35 * absf(sin(phase * 2.1))
			draw_polyline(points, Color(0.18, 0.76, 1.0, pulse * 0.4), 13.0, false)
			draw_polyline(points, Color(0.24, 0.82, 1.0, pulse), 6.0, false)
			draw_polyline(points, Color(0.96, 1.0, 1.0, 0.8 + pulse * 0.2), 2.4, false)
			for branch_idx in [3, 7]:
				var base: Vector2 = points[branch_idx]
				var branch_side: float = 1.0 if branch_idx == 3 else -1.0
				var branch_end: Vector2 = base + direction * 14.0 + normal * (branch_side * (10.0 + 6.0 * sin(phase + float(branch_idx))))
				draw_line(base, branch_end, Color(0.72, 0.97, 1.0, pulse), 2.0)
		elif bool(shot.get("green_arrow", false)):
			# A clearly readable green-fletched arrow, with the point aimed along
			# its actual travel direction (never a flat circular projectile).
			var arrow_direction: Vector2 = Vector2(shot["velocity"]).normalized()
			var arrow_normal: Vector2 = Vector2(-arrow_direction.y, arrow_direction.x)
			var arrow_tip: Vector2 = shot_screen + arrow_direction * 17.0
			var arrow_tail: Vector2 = shot_screen - arrow_direction * 16.0
			var arrow_shoulder: Vector2 = shot_screen + arrow_direction * 7.0
			# Dark outline makes the shaft visible over grass and foliage.
			draw_line(arrow_tail, arrow_tip, Color("163f1d"), 5.5)
			draw_line(arrow_tail, arrow_tip, Color("8be56b"), 2.8)
			draw_colored_polygon(PackedVector2Array([
				arrow_tip + arrow_direction * 2.0,
				arrow_shoulder + arrow_normal * 5.5,
				arrow_shoulder - arrow_normal * 5.5
			]), Color("39c65c"))
			# Bright green rear fletching, not an additional projectile.
			draw_line(arrow_tail, arrow_tail + arrow_direction * 10.0 + arrow_normal * 5.0, Color("39d75b"), 2.5)
			draw_line(arrow_tail, arrow_tail + arrow_direction * 10.0 - arrow_normal * 5.0, Color("39d75b"), 2.5)
		else:
			draw_circle(shot_screen, 6.0, shot["color"])
	draw_sanctuary_return_portal(camera)
	# Very brief electrical burst at an enemy hit by a God Sword bolt.
	for impact in lightning_impacts:
		var ip: Vector2 = Vector2(impact["pos"]) - camera
		var brightness: float = clampf(float(impact["time"]) / 0.23, 0.0, 1.0)
		if impact.has("start"):
			var origin: Vector2 = Vector2(impact["start"]) - camera
			var delta_bolt: Vector2 = ip - origin
			var normal: Vector2 = Vector2(-delta_bolt.y, delta_bolt.x).normalized()
			var bolt_points: PackedVector2Array = PackedVector2Array()
			for bolt_step in range(13):
				var t: float = float(bolt_step) / 12.0
				var jitter: float = 0.0 if bolt_step == 0 or bolt_step == 12 else sin(float(bolt_step) * 17.0 + lightning_clock * 30.0) * 11.0
				bolt_points.append(origin.lerp(ip, t) + normal * jitter)
			draw_polyline(bolt_points, Color(0.16, 0.67, 1.0, brightness * 0.60), 12.0, false)
			draw_polyline(bolt_points, Color(0.43, 0.88, 1.0, brightness), 5.0, false)
			draw_polyline(bolt_points, Color(0.97, 1.0, 1.0, brightness), 2.0, false)
		for ray in range(7):
			var angle: float = TAU * float(ray) / 7.0 + lightning_clock * 8.0
			var end: Vector2 = ip + Vector2.RIGHT.rotated(angle) * (12.0 + 22.0 * (1.0 - brightness))
			draw_line(ip, end, Color(0.65, 0.94, 1.0, brightness), 2.5)
	var player_center := VIEW * 0.5
	if active_slot == 0 and knight_ability_timer > 0.0:
		draw_knight_barrier_orbit(player_center)
	if active_slot == 0 and bladestorm_timer > 0.0:
		draw_bladestorm_orbit(player_center)
	if invulnerable <= 0.0 or int(invulnerable * 10.0) % 2 == 0 or knight_ability_timer > 0.0:
		if active_slot == 0:
			draw_warrior_player(player_center)
		else:
			draw_default_player(player_center)
	# Floating numbers follow world coordinates, rise, and fade over 0.9 seconds.
	for popup in combat_texts:
		var pos: Vector2 = Vector2(popup["pos"]) - camera
		var opacity: float = clampf(float(popup["time"]) / float(popup["duration"]), 0.0, 1.0)
		var is_critical: bool = bool(popup.get("critical", false))
		var popup_color: Color = CRIT_COLOR if is_critical else (HEAL_COLOR if bool(popup["healing"]) else DAMAGE_COLOR)
		popup_color.a = opacity
		var shown: String = ("CRIT! " if is_critical else ("+" if bool(popup["healing"]) else "-")) + str(int(popup["number"]))
		var font: Font = ThemeDB.fallback_font
		var font_size: int = 28 if is_critical else 22
		var shown_width: float = font.get_string_size(shown, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		draw_string_outline(font, pos + Vector2(-shown_width * 0.5, 0), shown, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, 3, Color(0.05, 0.07, 0.10, opacity))
		draw_string(font, pos + Vector2(-shown_width * 0.5, 0), shown, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, popup_color)
	draw_rect(Rect2(0, 0, VIEW.x, 72), Color("121827"))
	draw_rect(Rect2(13, 73, 212, 28), Color("151f29", 0.92))
	draw_label("Bat Cave Dungeon" if dungeon_active else zone_name(current_zone_id), Vector2(24, 94), 16, Color("f5dfad"))
	if dungeon_active:
		for enemy in enemies:
			if int(enemy["type"]) == 2 and player.distance_to(DUNGEON_BOSS_CENTER) < 750.0:
				draw_rect(Rect2(240, 75, 485, 47), Color("1d1127", 0.94))
				draw_label("MORVEX, THE BLOOD ECHO  -  LV. 15", Vector2(284, 92), 17, Color("f8b5cb"))
				draw_rect(Rect2(260, 103, 440, 10), Color("472530"))
				draw_rect(Rect2(260, 103, 440.0 * clampf(float(enemy["hp"]) / MORVEX_HP, 0.0, 1.0), 10), Color("cb304b"))
				break
	draw_label("%s  Lv %d" % [CLASSES[active_slot], slots[active_slot]["level"]], Vector2(18, 24), 20, COLORS[active_slot])
	draw_rect(Rect2(18, 36, 200, 13), Color("502b36"))
	draw_rect(Rect2(18, 36, 200.0 * hp / max_hp, 13), Color("d64e65"))
	draw_label("HP %d / %d" % [int(hp), int(max_hp)], Vector2(230, 48), 16)
	var needed := xp_needed(int(slots[active_slot]["level"]))
	if int(slots[active_slot]["level"]) >= LEVEL_CAP:
		draw_label("XP MAX", Vector2(420, 24), 17, Color("f6e19e"))
	else:
		draw_label("XP %d/%d" % [slots[active_slot]["xp"], needed], Vector2(420, 24), 17)
	draw_label("Gold %d   Kills %d" % [slots[active_slot]["gold"], kills], Vector2(VIEW.x - 280, 24), 17, Color("f5d48c"))
	var control_text := "Knight: sword swing + Aegis barrier (Q)  /  others: ranged attacks" if active_slot == 0 else "WASD move / click attack / Esc character menu"
	draw_label(control_text, Vector2(VIEW.x - 440, 52), 13, Color("b8c5da"))
	if status_timer > 0.0:
		draw_label(status_message, Vector2(VIEW.x * 0.5 - 130, 110), 21, Color("fff1b7"))
	if fountain_heal_notice > 0.0:
		draw_label("HEALING +18 HP/SEC", Vector2(367, 143), 18, Color("b2f6e8"))
	if dead_timer > 0.0:
		draw_rect(Rect2(245, 200, 470, 116), Color("0b1020"))
		draw_label("YOU HAVE FALLEN", Vector2(349, 242), 27, Color("f08991"))
		draw_label("Respawning at sanctuary...", Vector2(345, 280), 18)
	var joy_center := joystick_origin if left_touch != -1 else Vector2(90, VIEW.y - 103)
	draw_arc(joy_center, 62, 0, TAU, 40, Color("c5d8e5", 0.6), 3)
	var joy_offset := (joystick_current - joystick_origin).limit_length(62) if left_touch != -1 else Vector2.ZERO
	draw_circle(joy_center + joy_offset, 22, Color("c5d8e5", 0.35))
	draw_arc(FIRE_CENTER, 51, 0, TAU, 40, Color("efb47d", 0.75), 3)
	if mobile_fire and fire_stick_mode:
		var fire_offset: Vector2 = (fire_stick_position - fire_stick_origin).limit_length(47.0)
		draw_circle(FIRE_CENTER + fire_offset, 19, Color("efb47d", 0.55))
	else:
		draw_label("FIRE", FIRE_CENTER + Vector2(-18, 8), 17, Color("efc59d"))
	# Inventory button and town portal button are always accessible during gameplay.
	draw_rect(INVENTORY_BUTTON, Color("26394b"))
	draw_rect(INVENTORY_BUTTON, Color("d7bd82"), false, 2.0)
	draw_bag_icon(INVENTORY_BUTTON.position + Vector2(51, 28), 0.95)
	draw_rect(PORTAL_BUTTON, Color("21364c"))
	draw_rect(PORTAL_BUTTON, Color("8ed7ff") if portal_cast_timer > 0.0 else Color("d7bd82"), false, 2.0)
	draw_portal_icon(PORTAL_BUTTON.position + PORTAL_BUTTON.size * 0.5, 1.0)
	if portal_cast_timer > 0.0:
		draw_label("%1.1fs" % portal_cast_timer, PORTAL_BUTTON.position + Vector2(22, 45), 14, Color("dff7ff"))
	# Portal button intentionally uses its icon alone; no "PORT" lettering.
	# Stats button now uses a chart icon instead of text.
	draw_rect(STAT_BUTTON, Color("243d48"))
	draw_rect(STAT_BUTTON, Color("88d3a3") if int(slots[active_slot]["stat_points"]) > 0 else Color("b5b8ba"), false, 2.0)
	draw_stats_icon(STAT_BUTTON.position + STAT_BUTTON.size * 0.5, 1.0)
	if int(slots[active_slot]["stat_points"]) > 0:
		draw_circle(STAT_BUTTON.position + Vector2(91, 7), 11.0, Color("dce79d"))
		draw_label("!", STAT_BUTTON.position + Vector2(87, 12), 15, Color("324229"))
	if active_slot == 0:
		var ability_mode: String = knight_ability_mode()
		var is_blade: bool = ability_mode == "bladestorm"
		var duration: float = bladestorm_timer if is_blade else knight_ability_timer
		var ability_border: Color = Color("f26870") if duration > 0.0 and is_blade else (Color("a8f2ff") if duration > 0.0 else (Color("f3e28d") if knight_ability_is_ready() else Color("8795a3")))
		draw_rect(KNIGHT_ABILITY_BUTTON, Color("4b2029") if is_blade else Color("24495f") if duration > 0.0 else Color("1d2733"))
		draw_rect(KNIGHT_ABILITY_BUTTON, ability_border, false, 2.0)
		if is_blade:
			for blade in range(3):
				var a: float = float(blade) * TAU / 3.0
				var tip: Vector2 = KNIGHT_ABILITY_BUTTON.position + Vector2(52, 21) + Vector2.UP.rotated(a) * 18.0
				draw_line(tip - Vector2.UP.rotated(a) * 11.0, tip, Color("f05a64"), 4.0)
			draw_label("BLADE", KNIGHT_ABILITY_BUTTON.position + Vector2(33, 40), 11, Color("ffbdc0"))
		else:
			draw_knight_ability_icon(KNIGHT_ABILITY_BUTTON.position + Vector2(52, 21), 0.88, knight_ability_is_ready() or knight_ability_timer > 0.0)
			if ability_mode == "none":
				draw_label("EQUIP", KNIGHT_ABILITY_BUTTON.position + Vector2(34, 40), 11, Color("b9c1ca"))
			else:
				draw_label("AEGIS", KNIGHT_ABILITY_BUTTON.position + Vector2(34, 40), 11, Color("d0ecff"))
		var charge_back: Rect2 = Rect2(KNIGHT_ABILITY_BUTTON.position + Vector2(9, 44), Vector2(86, 7))
		draw_rect(charge_back, Color("111820"))
		var charge: int = 0
		if is_blade:
			charge = bladestorm_charge
		elif ability_mode == "aegis":
			charge = knight_ability_charge
		var fill_fraction: float = clampf(float(charge) / float(KNIGHT_ABILITY_REQUIRED), 0.0, 1.0)
		if duration > 0.0:
			fill_fraction = clampf(duration / (BLADESTORM_DURATION if is_blade else KNIGHT_ABILITY_DURATION), 0.0, 1.0)
		draw_rect(Rect2(charge_back.position, Vector2(charge_back.size.x * fill_fraction, charge_back.size.y)), Color("ef606b") if is_blade else Color("78e7ff"))
		draw_rect(charge_back, Color("c3d4e1"), false, 1.0)
	if nearest_ground_item_index() >= 0 and dead_timer <= 0.0 and not inventory_open and not shop_open and not bank_open:
		draw_rect(LOOT_BUTTON, Color("254e50"))
		draw_rect(LOOT_BUTTON, Color("c0efc7"), false, 2.0)
		# Stylized raised hand icon.
		var hand_at: Vector2 = LOOT_BUTTON.position + Vector2(15, 13)
		draw_rect(Rect2(hand_at + Vector2(6, 10), Vector2(19, 17)), Color("edc69c"))
		for digit in range(4):
			draw_rect(Rect2(hand_at + Vector2(6 + digit * 5, 1), Vector2(4, 15)), Color("edc69c"))
		draw_label("LOOT", LOOT_BUTTON.position + Vector2(47, 35), 19, Color("ecffed"))
	if player.distance_to(ORACLE_POS) <= ORACLE_TALK_RADIUS and not inventory_open and not shop_open and not bank_open and not stat_window_open and not oracle_open:
		draw_rect(ORACLE_BUTTON, Color("4e3b70"))
		draw_rect(ORACLE_BUTTON, Color("c3b3ec"), false, 2.0)
		draw_label("ORACLE", ORACLE_BUTTON.position + Vector2(17, 33), 20, Color("f7edff"))
	if player.distance_to(BANKER_POS) <= BANKER_TALK_RADIUS and not inventory_open and not shop_open and not bank_open:
		draw_rect(BANKER_BUTTON, Color("345846"))
		draw_rect(BANKER_BUTTON, Color("b2e8ad"), false, 2.0)
		draw_label("BANK", BANKER_BUTTON.position + Vector2(32, 33), 20, Color("eaffdf"))
	if player.distance_to(SWORD_MERCHANT_POS) <= MERCHANT_TALK_RADIUS and not inventory_open and not shop_open and not bank_open:
		draw_rect(SHOP_BUTTON, Color("334d62"))
		draw_rect(SHOP_BUTTON, Color("ecd399"), false, 2.0)
		draw_label("TALK", SHOP_BUTTON.position + Vector2(31, 34), 22, Color("fff1c5"))
	if inventory_open:
		draw_inventory()
	if shop_open:
		draw_shop()
	if bank_open:
		draw_bank()
	if stat_window_open:
		draw_stats_window()
	if oracle_open:
		# Fixed-size modal, centered on widescreen canvases.
		draw_set_transform((VIEW - DESIGN_VIEW) * 0.5)
		draw_oracle_panel()
		draw_set_transform(Vector2.ZERO)


func class_equipment_drop_pool(class_index: int) -> Array:
	match class_index:
		0: return ["plate_helm", "plate_chest", "plate_legs", "iron_sword", "iron_greatsword", "steel_shield"]
		1: return ["leather_cap", "leather_vest", "leather_leggings", "short_bow", "quiver"]
		2: return ["cloth_hood", "cloth_robe", "cloth_pants", "apprentice_wand", "spellbook", "sorcerer_staff"]
		3: return ["cloth_hood", "cloth_robe", "cloth_pants", "cleric_mace", "holy_book", "cleric_sceptre"]
		4: return ["leather_cap", "leather_vest", "leather_leggings", "rogue_dagger", "rogue_offhand_dagger"]
	return []

func item_allowed_for_class(item_id: String, class_index: int) -> bool:
	if not ITEM_DATA.has(item_id):
		return false
	var def: Dictionary = ITEM_DATA[item_id]
	if str(def.get("slot", "")) == "cosmetic":
		return true
	var base: String = item_base_id(item_id)
	# Armors are restricted by their materials. Shared cloth/leather are
	# deliberately allowed for two classes without relying on a single class ID.
	if base == "leather_cap" or base == "leather_vest" or base == "leather_leggings":
		return class_index == 1 or class_index == 4
	if base == "cloth_hood" or base == "cloth_robe" or base == "cloth_pants":
		return class_index == 2 or class_index == 3
	if base == "plate_helm" or base == "plate_chest" or base == "plate_legs":
		return class_index == 0
	# Deprecated iron/chain armor remains accessible in old saves but can no
	# longer be newly equipped under the class-specific armor system.
	if base == "iron_helm" or base == "chain_armor" or base == "priest_staff" or base == "holy_relic" or base == "throwing_knife":
		return false
	return not def.has("class") or int(def["class"]) == class_index

func is_two_handed_weapon(item_id: String) -> bool:
	if not ITEM_DATA.has(item_id):
		return false
	return bool(ITEM_DATA[item_id].get("two_handed", false))

func get_equipment_bonus(stat: String) -> float:
	if active_slot < 0:
		return 0
	var bonus: float = 0.0
	var equip: Dictionary = slots[active_slot]["equipment"]
	for key in EQUIP_KEYS:
		var item_id: String = str(equip.get(key, ""))
		if ITEM_DATA.has(item_id):
			bonus += float(ITEM_DATA[item_id].get(stat, 0))
	return bonus

func bag_items() -> Array:
	return slots[active_slot]["bag"]

func cell_is_clear(x: int, y: int, w: int, h: int, skip: int = -1) -> bool:
	if x < 0 or y < 0 or x + w > BAG_COLS or y + h > BAG_ROWS:
		return false
	var bag: Array = bag_items()
	for i in range(bag.size()):
		if i == skip:
			continue
		var placed: Dictionary = bag[i]
		var definition: Dictionary = ITEM_DATA[str(placed["id"])]
		var px := int(placed["x"])
		var py := int(placed["y"])
		var pw := int(definition["w"])
		var ph := int(definition["h"])
		if x < px + pw and x + w > px and y < py + ph and y + h > py:
			return false
	return true

func find_space(item_id: String) -> Vector2i:
	var definition: Dictionary = ITEM_DATA[item_id]
	for y in range(BAG_ROWS):
		for x in range(BAG_COLS):
			if cell_is_clear(x, y, int(definition["w"]), int(definition["h"])):
				return Vector2i(x, y)
	return Vector2i(-1, -1)

func add_item_to_bag(item_id: String, quantity: int = 1) -> bool:
	if not ITEM_DATA.has(item_id) or quantity < 1:
		return false
	var bag: Array = bag_items()
	if is_elixer(item_id):
		var available: int = 0
		for existing_variant in bag:
			var existing: Dictionary = existing_variant
			if str(existing.get("id", "")) == item_id:
				available += maxi(0, ELIXER_STACK_MAX - stack_count(existing))
		for row in range(BAG_ROWS):
			for col in range(BAG_COLS):
				if cell_is_clear(col, row, 1, 1):
					available += ELIXER_STACK_MAX
		if available < quantity:
			return false
		var remaining: int = quantity
		for i in range(bag.size()):
			var existing: Dictionary = bag[i]
			if str(existing.get("id", "")) != item_id:
				continue
			var add_count: int = mini(remaining, ELIXER_STACK_MAX - stack_count(existing))
			if add_count > 0:
				existing["count"] = stack_count(existing) + add_count
				bag[i] = existing
				remaining -= add_count
			if remaining == 0:
				break
		while remaining > 0:
			var spot: Vector2i = find_space(item_id)
			if spot.x < 0:
				return false
			var to_add: int = mini(remaining, ELIXER_STACK_MAX)
			bag.append({"id": item_id, "x": spot.x, "y": spot.y, "count": to_add})
			remaining -= to_add
	else:
		if quantity != 1:
			return false
		var spot: Vector2i = find_space(item_id)
		if spot.x < 0:
			return false
		bag.append({"id": item_id, "x": spot.x, "y": spot.y})
	save_slots()
	return true

func item_at_cell(x: int, y: int) -> int:
	var bag: Array = bag_items()
	for i in range(bag.size()):
		var item: Dictionary = bag[i]
		var definition: Dictionary = ITEM_DATA[str(item["id"])]
		if x >= int(item["x"]) and x < int(item["x"]) + int(definition["w"]) and y >= int(item["y"]) and y < int(item["y"]) + int(definition["h"]):
			return i
	return -1

func equip_bag_item(index: int) -> void:
	var bag: Array = bag_items()
	if index < 0 or index >= bag.size():
		return
	var item: Dictionary = bag[index]
	var item_id: String = str(item["id"])
	var definition: Dictionary = ITEM_DATA[item_id]
	if is_elixer(item_id):
		selected_bag_index = index
		elixer_confirmation = true
		return
	if not item_allowed_for_class(item_id, active_slot):
		status_message = "This equipment cannot be used by your class"
		status_timer = 2.0
		return
	var equip: Dictionary = slots[active_slot]["equipment"]
	var key: String = str(definition["slot"])
	if key == "weapon" and is_two_handed_weapon(item_id) and str(equip.get("offhand", "")) != "":
		status_message = "Unequip your offhand before using a two-handed weapon"
		status_timer = 3.0
		return
	if key == "offhand" and is_two_handed_weapon(str(equip.get("weapon", ""))):
		status_message = "Two-handed weapons cannot use offhand equipment"
		status_timer = 3.0
		return
	var old_id: String = str(equip.get(key, ""))
	var previous_max_hp: float = max_hp
	# Replace the selected bag item with the old gear, if present.
	bag.remove_at(index)
	if old_id != "":
		if not add_item_to_bag(old_id):
			bag.insert(index, item)
			status_message = "Not enough room for equipped item"
			status_timer = 2.0
			return
	equip[key] = item_id
	if active_slot == 0:
		if not knight_has_shield():
			knight_ability_timer = 0.0
		if not knight_has_two_handed():
			bladestorm_timer = 0.0
	refresh_equipment_hp(previous_max_hp)
	selected_bag_index = -1
	status_message = "Equipped " + str(definition["name"])
	status_timer = 2.0
	save_slots()

func unequip_slot(key: String) -> void:
	var equip: Dictionary = slots[active_slot]["equipment"]
	var item_id: String = str(equip.get(key, ""))
	if item_id == "":
		return
	if add_item_to_bag(item_id):
		var previous_max_hp: float = max_hp
		equip[key] = ""
		if active_slot == 0:
			if not knight_has_shield():
				knight_ability_timer = 0.0
			if not knight_has_two_handed():
				bladestorm_timer = 0.0
		refresh_equipment_hp(previous_max_hp)
		status_message = "Moved item to backpack"
		status_timer = 2.0
		save_slots()
	else:
		status_message = "Backpack is full"
		status_timer = 2.0

func toggle_inventory() -> void:
	inventory_open = not inventory_open
	selected_bag_index = -1
	destroy_confirmation = false
	elixer_confirmation = false
	left_touch = -1
	right_touch = -1
	pointer_held = false
	mobile_fire = false
	fire_stick_mode = false
	save_slots()

func confirm_consume_elixer() -> void:
	var bag: Array = bag_items()
	if selected_bag_index < 0 or selected_bag_index >= bag.size():
		elixer_confirmation = false
		return
	var item: Dictionary = bag[selected_bag_index]
	var item_id: String = str(item.get("id", ""))
	if not is_elixer(item_id):
		elixer_confirmation = false
		return
	var stat_name: String = str(ITEM_DATA[item_id]["stat"])
	var stats: Dictionary = slots[active_slot]["stats"]
	stats[stat_name] = int(stats.get(stat_name, 0)) + 1
	var elixer_stats: Dictionary = slots[active_slot]["elixer_stats"]
	elixer_stats[stat_name] = int(elixer_stats.get(stat_name, 0)) + 1
	var count: int = stack_count(item) - 1
	if count <= 0:
		bag.remove_at(selected_bag_index)
		selected_bag_index = -1
	else:
		item["count"] = count
		bag[selected_bag_index] = item
	status_message = "Consumed Elixer: " + stat_name + " +1"
	status_timer = 2.6
	elixer_confirmation = false
	save_slots()
	queue_redraw()

func handle_inventory_tap(point: Vector2) -> void:
	if not inventory_open:
		if INVENTORY_BUTTON.has_point(point):
			toggle_inventory()
		return
	# Elixer confirmation is modal to prevent accidental stat changes.
	if elixer_confirmation:
		if ELIXER_CONFIRM_YES.has_point(point):
			confirm_consume_elixer()
		elif ELIXER_CONFIRM_NO.has_point(point):
			elixer_confirmation = false
		return
	# The confirmation dialog is modal: no other tap can move or equip gear.
	if destroy_confirmation:
		if DESTROY_CONFIRM.has_point(point):
			var bag: Array = bag_items()
			if selected_bag_index >= 0 and selected_bag_index < bag.size():
				var removed_id: String = str(bag[selected_bag_index]["id"])
				bag.remove_at(selected_bag_index)
				status_message = "Destroyed %s" % str(ITEM_DATA[removed_id]["name"])
				status_timer = 2.5
				selected_bag_index = -1
				save_slots()
			destroy_confirmation = false
		elif DESTROY_CANCEL.has_point(point):
			destroy_confirmation = false
		return
	if ELIXER_CONSUME_BUTTON.has_point(point):
		var bag: Array = bag_items()
		if selected_bag_index >= 0 and selected_bag_index < bag.size() and is_elixer(str(bag[selected_bag_index]["id"])):
			elixer_confirmation = true
		return
	if DESTROY_BUTTON.has_point(point):
		var bag: Array = bag_items()
		if selected_bag_index >= 0 and selected_bag_index < bag.size():
			destroy_confirmation = true
		return
	if Rect2(835, 75, 70, 50).has_point(point):
		toggle_inventory()
		return
	for i in range(EQUIP_POS.size()):
		if Rect2(EQUIP_POS[i] - Vector2(48, 22), Vector2(96, 49)).has_point(point):
			if selected_bag_index != -1:
				var bag: Array = bag_items()
				if selected_bag_index < bag.size():
					var item_id: String = str(bag[selected_bag_index]["id"])
					if str(ITEM_DATA[item_id]["slot"]) == str(EQUIP_KEYS[i]):
						equip_bag_item(selected_bag_index)
						return
			unequip_slot(str(EQUIP_KEYS[i]))
			return
	var local: Vector2 = point - BAG_ORIGIN
	var pitch := BAG_CELL + BAG_GAP
	var x := int(floor(local.x / pitch))
	var y := int(floor(local.y / pitch))
	if x < 0 or y < 0 or x >= BAG_COLS or y >= BAG_ROWS:
		return
	var i := item_at_cell(x, y)
	if i != -1:
		if selected_bag_index == i:
			equip_bag_item(i)
		else:
			selected_bag_index = i
	else:
		if selected_bag_index < 0:
			return
		var bag: Array = bag_items()
		if selected_bag_index >= bag.size():
			return
		var item: Dictionary = bag[selected_bag_index]
		var definition: Dictionary = ITEM_DATA[str(item["id"])]
		if cell_is_clear(x, y, int(definition["w"]), int(definition["h"]), selected_bag_index):
			item["x"] = x
			item["y"] = y
			bag[selected_bag_index] = item
			selected_bag_index = -1
			save_slots()

func draw_inventory() -> void:
	# All interface elements use touch-sized targets in landscape orientation.
	draw_rect(Rect2(47, 58, 866, 436), Color("101725"))
	draw_rect(Rect2(47, 58, 866, 436), Color("d8b87a"), false, 3.0)
	draw_label("CHARACTER EQUIPMENT", Vector2(88, 102), 23, Color("f2d99b"))
	draw_label("BACKPACK", Vector2(488, 102), 23, Color("f2d99b"))
	draw_rect(Rect2(835, 75, 70, 50), Color("8e4845"))
	draw_label("X", Vector2(859, 110), 26)
	var equip: Dictionary = slots[active_slot]["equipment"]
	for i in range(EQUIP_KEYS.size()):
		var key: String = str(EQUIP_KEYS[i])
		var item_id: String = str(equip.get(key, ""))
		var pos: Vector2 = EQUIP_POS[i]
		draw_rect(Rect2(pos - Vector2(48, 22), Vector2(96, 49)), Color("303b4d"))
		var equip_border: Color = Color("a38c66") if item_id == "" else item_border_color(item_id)
		draw_rect(Rect2(pos - Vector2(48, 22), Vector2(96, 49)), equip_border, false, 2.0)
		if item_id == "":
			draw_label(str(EQUIP_NAMES[i]), pos + Vector2(-35, 7), 15, Color("aeb7cb"))
		else:
			var def: Dictionary = ITEM_DATA[item_id]
			draw_item_icon(item_id, pos + Vector2(-32, 1), inventory_icon_scale(item_id, Vector2(58, 43), 0.45))
			draw_label(str(EQUIP_NAMES[i]), pos + Vector2(-18, -3), 13, Color("d6ddea"))
			draw_label("VISUAL ONLY" if key == "cosmetic" else gear_stat_label(def), pos + Vector2(-18, 16), 10, Color("f6d999"))
	for y in range(BAG_ROWS):
		for x in range(BAG_COLS):
			var cell_pos := BAG_ORIGIN + Vector2(x, y) * (BAG_CELL + BAG_GAP)
			draw_rect(Rect2(cell_pos, Vector2(BAG_CELL, BAG_CELL)), Color("293347"))
			draw_rect(Rect2(cell_pos, Vector2(BAG_CELL, BAG_CELL)), Color("536078"), false, 1.0)
	var bag: Array = bag_items()
	for i in range(bag.size()):
		var item: Dictionary = bag[i]
		var definition: Dictionary = ITEM_DATA[str(item["id"])]
		var item_pos: Vector2 = BAG_ORIGIN + Vector2(int(item["x"]), int(item["y"])) * (BAG_CELL + BAG_GAP)
		var item_size := Vector2(float(int(definition["w"])) * (BAG_CELL + BAG_GAP) - BAG_GAP, float(int(definition["h"])) * (BAG_CELL + BAG_GAP) - BAG_GAP)
		draw_rect(Rect2(item_pos, item_size), Color(str(definition["color"])))
		draw_rect(Rect2(item_pos, item_size), item_border_color(str(item["id"])), false, 3.0)
		if selected_bag_index == i:
			draw_rect(Rect2(item_pos + Vector2(3, 3), item_size - Vector2(6, 6)), Color("f6d99d"), false, 2.0)
		draw_item_icon(str(item["id"]), item_pos + item_size * 0.5, inventory_icon_scale(str(item["id"]), item_size, clampf(minf(item_size.x, item_size.y) / 50.0, 0.75, 1.5)))
		if is_elixer(str(item["id"])):
			draw_label("%d" % stack_count(item), item_pos + Vector2(item_size.x - 22.0, item_size.y - 6.0), 15, Color("ffffff"))
	# Tooltip and controls; one tap selects, second tap equips.
	draw_label("ATK +%d  CRIT %.0f%%" % [int(get_equipment_bonus("atk")), player_crit_chance() * 100.0], Vector2(92, 388), 16, Color("f4d793"))
	draw_label("DEF +%d  HP +%d" % [int(get_equipment_bonus("def")), int(get_equipment_bonus("hp"))], Vector2(92, 409), 16, Color("f4d793"))
	draw_label("Tap gear to remove", Vector2(105, 441), 14, Color("bfccde"))
	if selected_bag_index >= 0 and selected_bag_index < bag.size():
		var selected_item: Dictionary = bag[selected_bag_index]
		var selected_def: Dictionary = ITEM_DATA[str(selected_item["id"])]
		var selected_id: String = str(selected_item["id"])
		var detail_label: String = str(selected_def["name"]) + " x%d  (+1 %s when used)" % [stack_count(selected_item), str(selected_def["stat"])] if is_elixer(selected_id) else str(selected_def["name"]) + "   " + gear_stat_label(selected_def)
		draw_label(detail_label, Vector2(487, 437), 13, Color("f5dda4"))
	else:
		draw_label("Tap item, tap again to equip; tap empty cell to move", Vector2(483, 437), 14, Color("c8d4e6"))
	# The USE ELIXER action only exists visually for a selected Elixer.
	var can_consume: bool = selected_bag_index >= 0 and selected_bag_index < bag.size() and is_elixer(str(bag[selected_bag_index]["id"]))
	if can_consume:
		draw_rect(ELIXER_CONSUME_BUTTON, Color("346e56"))
		draw_rect(ELIXER_CONSUME_BUTTON, Color("9ee9bc"), false, 2.0)
		draw_label("USE ELIXER", ELIXER_CONSUME_BUTTON.position + Vector2(15, 26), 16, Color("ffffff"))
	# Selected backpack items can be discarded. Equipped items must be
	# unequipped into the backpack before they can be destroyed.
	var can_destroy: bool = selected_bag_index >= 0 and selected_bag_index < bag.size()
	draw_rect(DESTROY_BUTTON, Color("8c4044") if can_destroy else Color("3c404c"))
	draw_rect(DESTROY_BUTTON, Color("e7a0a0") if can_destroy else Color("697080"), false, 2.0)
	draw_label("DESTROY ITEM", Vector2(731, 470), 17, Color("fff5ed") if can_destroy else Color("a6adbd"))
	if elixer_confirmation:
		draw_rect(Rect2(263, 146, 434, 222), Color("111827"))
		draw_rect(Rect2(263, 146, 434, 222), Color("95d4ac"), false, 3.0)
		draw_label("CONSUME THIS ELIXER?", Vector2(302, 195), 23, Color("ffffff"))
		if selected_bag_index >= 0 and selected_bag_index < bag.size():
			var chosen_elixer: Dictionary = bag[selected_bag_index]
			var stat_name: String = str(ITEM_DATA[str(chosen_elixer["id"])]["stat"])
			draw_label("Permanently gain +1 " + stat_name, Vector2(322, 244), 18, Color("e6f7ff"))
		draw_rect(ELIXER_CONFIRM_YES, Color("3a8257"))
		draw_label("CONSUME", Vector2(321, 330), 19, Color("ffffff"))
		draw_rect(ELIXER_CONFIRM_NO, Color("425870"))
		draw_label("CANCEL", Vector2(521, 330), 20, Color("ffffff"))
	if destroy_confirmation:
		draw_rect(Rect2(263, 146, 434, 222), Color("111827"))
		draw_rect(Rect2(263, 146, 434, 222), Color("e3b16e"), false, 3.0)
		draw_label("DESTROY SELECTED ITEM?", Vector2(294, 193), 24, Color("ffe1a5"))
		if can_destroy:
			var chosen: Dictionary = bag[selected_bag_index]
			var item_def: Dictionary = ITEM_DATA[str(chosen["id"])]
			draw_label(str(item_def["name"]), Vector2(338, 241), 21, Color("ffffff"))
		draw_label("This cannot be undone.", Vector2(353, 270), 16, Color("f0a7a7"))
		draw_rect(DESTROY_CONFIRM, Color("a94747"))
		draw_label("DESTROY", Vector2(326, 330), 20, Color("ffffff"))
		draw_rect(DESTROY_CANCEL, Color("425870"))
		draw_label("CANCEL", Vector2(521, 330), 20, Color("ffffff"))

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_APPLICATION_PAUSED:
		save_slots()
