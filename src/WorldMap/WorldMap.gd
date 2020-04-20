extends Node2D
class_name WorldMap

signal tile_clicked

const SELECTED : int = 0
const CLEAR : int = -1
const TOWN : int = 0
const FARMLAND : int = 1
const GRASSLAND : int = 2
const WOODS : int = 3
const HILLS : int = 4
const SWAMP : int = 5
const MOUNTAIN : int = 6
const DESERT : int = 7
const JUNGLE : int = 8
const ALPINE : int = 9
const ARCTIC : int = 10
const OCEAN : int = 11
const NAMES = {
	TOWN: [
		"Ravenvault",
		"Kilband",
		"Chillbell",
		"Clearvault",
		"Greenpond",
		"Bearvale",
		"Lagoonwater",
		"Westdrift",
		"Bearburn",
		"Bridgewharf",
		"Glimmerhold",
		"Stillbreak",
		"Grimdenn",
		"Froststrand",
		"Duskbreach",
		"Oxband",
		"Wildeport",
		"Littlefront",
		"Lastspire",
		"Basinwind",
		"Stagdenn",
		"Eboncoast",
		"Falsewind",
		"Littlefell",
		"Saltburn",
		"Stagstorm",
		"Tradepond",
		"Rosehelm",
		"Hollowwall",
		"Lagoonfalls",
		"Lakevein",
		"Basinview",
		"Staghaven",
		"Steelham",
		"Barewatch",
		"Whalevault",
		"Fallside",
		"Ambercoast",
		"Goldmouth",
		"Stonewind",
		"Windhill",
		"Thorndrift",
		"Springgarde",
		"Falsegrove",
		"Angelmore",
		"Honeyband",
		"Basinwall",
		"Pinespell",
		"Steephollow",
		"Ravenbourne",
		"Boneshell",
		"Scorchvale",
		"Kilfield",
		"Deerhand",
		"Northwatch",
		"Slygulf",
		"Edgebell",
		"Whitrun",
		"Goldport",
		"Pineshell",
		"Blackborough",
		"Lakecliff",
		"Houndhallow",
		"Muteward",
		"Ghoststall",
		"Coldwell",
		"Goldham",
		"Grimpass",
		"Crowguard",
		"Goldwater",
		"Staghollow",
		"Silentforest",
		"Hazelgrove",
		"Madholde",
		"Stoneband",
		"Heartham",
		"Scorchstall",
		"Oldwallow",
		"Nevergulf",
		"Brittlepoint",
		"Mosshaven",
		"Swiftyard",
		"Mutedale",
		"Blackguard",
		"Flamefalls",
		"Claystar",
		"Mighthorn",
		"Mistfrost",
		"Silkhold",
		"Ghostborn",
		"Smallshell",
		"Littlepoint",
		"Bronzespell",
		"Cliffmouth",
		"Neverhallow",
		"Lagoontown",
		"Cursebell",
		"Lakecall",
		"Cliffcoast",
		"Boulderpoint"
	],
	FARMLAND: [
		"Chicken Egg Pastures",
		"Green Meadows Fields",
		"Jolly Green Lands",
		"Dogwood Farm",
		"Grand Mountain Fields",
		"Furball Lands",
		"Pegasus Meadow",
		"Blueberry Basket Meadow",
		"Freedom Gardens",
		"Big Bear Ranch",
		"Lock, Stock & Barrel Farmstead",
		"Bull's Eye Farm",
		"Mountain Ridge Estate",
		"Pumpkin Patch Gardens",
		"Wildflower Farmstead",
		"Starwood Acres",
		"Mountainridge Lands",
		"Mountain Ridge Range",
		"Dragon Hill Meadow",
		"Dragontooth Pastures",
		"Meadowbrooke Gardens",
		"Rise and Shine Lands",
		"Ravenwood Fields",
		"Sleepy Hollow Fields",
		"Talking Tree Gardens",
		"Rooster Vineyard",
		"Happy Range",
		"Gold Mine Estate",
		"Hazelwood Lands",
		"High Hill Ranch",
		"Borealis Lands",
		"Green River Farm",
		"Black Oak Ranch",
		"Day Break Farms",
		"Prairie Hills Farm",
		"Bear Creek Lands",
		"Furball Pastures",
		"Red Dog Farms",
		"Pine Springs Lands",
		"Tall Oaks Fields",
		"Big Bear Acres",
		"Little Acorn Farm",
		"Shooting Star Range",
		"Riverview Fields",
		"Green Haven Farm",
		"New Spring Vineyard",
		"Honey Comb Gardens",
		"Black Dog Fields",
		"Chestnut Grove Farms",
		"Lucky Lands",
		"Riverview Vineyard",
		"Roadrunner Nursery",
		"Dragon Hill Vineyard",
		"Bird's Nest Orchard",
		"Whitewater Estate",
		"Canyon Crossing Nursery",
		"Rosebush Pastures",
		"Meadowgrove Pastures",
		"Pine Estate",
		"Mossy Oak Grange",
		"Rock Bottom Fields",
		"Silverbell Vineyard",
		"Rooster Grange",
		"Black Hawk Acres",
		"Elysian Fields",
		"Crown Meadow Ranch",
		"Borealis Nursery",
		"Flying Pig Grange",
		"Green Meadows Orchard",
		"Little Wolf Gardens",
		"Lucky Farm",
		"New Dawn Gardens",
		"Green River Farm",
		"Sunset Grange",
		"Meadowbrooke Acres",
		"Moonlight Orchard",
		"Meadowbrooke Ranch",
		"Straight Arrow Vineyard",
		"Roadrunner Nursery",
		"Thistleberry Ranch",
		"Furball Acres",
		"Rolling Oak Estate",
		"Pine Valley Meadow",
		"Goose Feather Pastures",
		"Spring Fountain Pastures",
		"Moonlight Gardens",
		"Hidden Creek Fields",
		"Burning Sands Grange",
		"Silverbell Pastures",
		"End of the World Ranch",
		"Phoenix Ranch",
		"Lone Oak Gardens",
		"White Willow Acres",
		"Prairie Hills Nursery",
		"Evergreen Range",
		"Rolling Hills Range",
		"Moonlight Grange",
		"Big Oak Gardens",
		"Cherry Blossom Ranch",
		"Berry Crest Estate"
	],
	GRASSLAND: [
		"Banded Ant Gardens",
		"Cloud Jackal Valley",
		"Laughing Caterpillar Grassland",
		"Striped Buffalo Gardens",
		"Glorious Pastures",
		"Precious Territory",
		"Detailed Plateau",
		"Trotois Prairie",
		"Cliffland Grassland",
		"Wallinet Expanse",
		"Northern Frog Steppe",
		"Dotted Rat Grasslands",
		"Grand Ant Gardens",
		"Grassland Crane Plains",
		"Enchanted Territory",
		"Magnificent Grassland",
		"Deep Pastures",
		"Repencroft Territory",
		"Oakpids Plateau",
		"Irrishall Terrain",
		"Striped Mouse Gardens",
		"Pacific Crane Plateau",
		"Maned Bee Terrain",
		"Ivory Crow Plains",
		"Luscious Steppe",
		"Heavenly Steppe",
		"Windy Range",
		"Deadville Plains",
		"Readwick Steppe",
		"Causasend Territory",
		"Short-Tailed Ladybug Range",
		"Prairie Ladybug Territory",
		"Spotted Bee Meadow",
		"Noble Gazelle Pastures",
		"Private Plains",
		"Mighty Fields",
		"Simple Valley",
		"Lamarath Plateau",
		"Hflisle Territory",
		"Ogegue Gardens",
		"Masked Cougar Territory",
		"Cloud Bear Expanse",
		"Ebony Eagle Gardens",
		"Black Warthog Grasslands",
		"Wandering Savanna",
		"Whispering Gardens",
		"Windy Savanna",
		"Wrentburg Valley",
		"Nottingboro Plains",
		"Keelmeuse Gardens",
		"Eastern Cougar Terrain",
		"Brown Buzzard Expanse",
		"Northern Elephant Grassland",
		"Pacific Groundhog Plains",
		"Young Range",
		"Lively Plateau",
		"Marvelous Gardens",
		"Waburns Grasslands",
		"Turlis Plains",
		"Davelbo Steppe",
		"Mountain Bison Pastures",
		"Northern Buzzard Valley",
		"Black Badger Grasslands",
		"Banded Baboon Steppe",
		"Awesome Meadow",
		"Scattered Gardens",
		"Young Territory",
		"Burhead Pastures",
		"Pascola Steppe",
		"Lamnan Gardens",
		"Grass Rhino Grassland",
		"Imperial Dingo Plateau",
		"Maned Bison Gardens",
		"Short-Tailed Lion Pastures",
		"Deserted Savanna",
		"Glistening Territory",
		"Young Pastures",
		"Chilmont Gardens",
		"Rowrich Territory",
		"Dupartane Terrain",
		"Imperial Frog Prairie",
		"Western Butterfly Plateau",
		"Ebony Anaconda Valley",
		"Speckled Fox Pastures",
		"Rainy Prairie",
		"Whispering Grassland",
		"Glorious Grassland",
		"Portdows Grassland",
		"Witfell Fields",
		"Millcroft Plateau",
		"Laughing Bird Pastures",
		"Taiga Chipmunk Steppe",
		"Southern Lion Steppe",
		"Giant Rhino Range",
		"Misty Grasslands",
		"Unknown Terrain",
		"Gigantic Valley",
		"Norpar Plains",
		"Southshire Range",
		"Emsmere Grasslands"
	],
	WOODS: [
		"Spectacular Spruce Wilds",
		"Rare Hazelnut Woodland",
		"Groovy Wood",
		"Lively Thicket",
		"Royal Gazelle Forest",
		"Brown Okapi Covert",
		"Northgeo Grove",
		"Maidmis Woodland",
		"Baincaster Woods",
		"Stratdows Forest",
		"Light Mount Woodland",
		"Brass Chestnut Woodland",
		"Colossal Covert",
		"Lonely Forest",
		"Pygmy Leopard Timberland",
		"Laughing Alligator Forest",
		"Cottlenet Woods",
		"Flemborough Grove",
		"Hamram Timberland",
		"Gaulborg Forest",
		"Teeny Birch Wilds",
		"Waiting Tupelo Covert",
		"Whimsical Timberland",
		"Enchanted Wood",
		"Wild Spider Forest",
		"Brown Crab Timberland",
		"Votshaw Forest",
		"Mayden Woodland",
		"Turborg Forest",
		"Horsgeo Forest",
		"Awesome Harlequin Covert",
		"Regular Harlequin Thicket",
		"Dramatic Forest",
		"Dramatic Woods",
		"Wild Tiger Woodland",
		"Speckled Panther Wood",
		"Barringtrie Woodland",
		"Nicocour Wood",
		"Coatigus Covert",
		"Forlants Wood",
		"Whispering Elderberry Thicket",
		"Naive Blackberry Woods",
		"Spiritual Woodland",
		"Shadow Covert",
		"Speckled Pygmy Owl Wilds",
		"Lesser Leopard Wood",
		"Cochly Grove",
		"Ingerlinet Timberland",
		"Argeo Timberland",
		"Cumbersevain Woods",
		"Quiet Silverbell Forest",
		"Foolish Hazelnut Wood",
		"Jagged Wood",
		"Pleasant Timberland",
		"Lesser Fox Timberland",
		"Royal Frog Forest",
		"Hartisle Forest",
		"Lumney Grove",
		"Autumnborough Forest",
		"Shauriden Timberland",
		"Enchanted Linden Woods",
		"Beautiful Juniper Wood",
		"Venomous Forest",
		"Puny Woods",
		"Speckled Warthog Woodland",
		"Brown Bandicoot Timberland",
		"Humbron Forest",
		"Maychester Wilds",
		"Parrlet Woods",
		"Templethon Woodland",
		"Unique Beech Timberland",
		"False Maple Timberland",
		"Tiny Woods",
		"Marvelous Grove",
		"White Sunbird Woodland",
		"Common Bandicoot Covert",
		"Poncam Covert",
		"Newwe Woods",
		"Buchpool Timberland",
		"Chatfield Timberland",
		"Wretched Stream Wood",
		"Misty Hickory Wilds",
		"Romantic Woodland",
		"Lush Woodland",
		"Maned Anteater Timberland",
		"Pacific Jackal Forest",
		"Middlebourg Wood",
		"Trentona Covert",
		"Readmond Thicket",
		"Roscola Wilds",
		"Terrific Birch Wood",
		"Broad Elderberry Wilds",
		"Abandoned Timberland",
		"Faint Thicket",
		"Savanna Deer Forest",
		"Little Jaguar Woodland",
		"Latchmack Woodland",
		"Turhead Thicket",
		"Temissons Wood",
		"Boothvern Thicket"
	],
	SWAMP: [
		"The Rippling Swamp",
		"The Silent Glades",
		"Perfumed Glades",
		"Dying Polder",
		"Vauxpawa Labyrinth",
		"Bevercier Abyss",
		"Roxborg Waters",
		"The Basin of Deadpon",
		"The Marsh of Canterher",
		"The Mangrove of Clareston",
		"The Pleasant Morass",
		"The Rocking Abyss",
		"Foaming Swamp",
		"Boiling Bowels",
		"Leecastle Quagmire",
		"Bellemont Mangrove",
		"Hasmiota Waters",
		"The Quagmire of Mansomin",
		"The Abyss of Grimrial",
		"The Abyss of Cornmiota",
		"The Charmed Bog",
		"The Deepest Glades",
		"Living Glades",
		"Majestic Bowels",
		"Brighsevain Cove",
		"Fordfield Quag",
		"Alberwood Mire",
		"The Polder of Huntingston",
		"The Mangrove of Burboia",
		"The Wetlands of Hillan",
		"The Dense Wetlands",
		"The Slumbrous Mire",
		"Tinted Glades",
		"Tortoise Glades",
		"Carboham Quag",
		"Shelton Basin",
		"Gallanworth Bog",
		"The Basin of Corroy",
		"The Glades of Minigan",
		"The Cove of Jolris",
		"The Treacherous Cove",
		"The Infinite Abyss",
		"Rough Bowels",
		"Dread Marsh",
		"Shiphead Glades",
		"Raysonee Marsh",
		"Smithstrie Glades",
		"The Quag of Tuntrie",
		"The Abyss of Flatby",
		"The Mire of Rochwater",
		"The Perfumed Slough",
		"The Infinite Basin",
		"Homeless Quagmire",
		"Black Slough",
		"Windsor Glades",
		"Ambel Labyrinth",
		"Radning Abyss",
		"The Marsh of Kinibrook",
		"The Cove of Arlingfield",
		"The Bog of Itumouth",
		"The Sparkling Basin",
		"The Troubled Mangrove",
		"Raging Slough",
		"Soundless Waters",
		"Malarthon Quag",
		"Cowanline Morass",
		"Yorkcola Quag",
		"The Slough of Fairmar",
		"The Basin of Nicoview",
		"The Bog of Salistou",
		"The Blue Labyrinth",
		"The Arrowhead Quag",
		"Lotus Slough",
		"Glistening Wetlands",
		"Broscam Bog",
		"Birmingrock Mangrove",
		"Riverval Bog",
		"The Glades of Camport",
		"The Waters of Grandmont",
		"The Polder of Granminster",
		"The Eastern Slough",
		"The Rough Cove",
		"Dense Basin",
		"Unfathomed Polder",
		"Berkholm Cove",
		"Coaticoln Bowels",
		"Esterlin Slough",
		"The Quagmire of Colry",
		"The Bog of Winland",
		"The Basin of Maratane",
		"The Blue Slough",
		"The Living Basin",
		"Wrinkled Labyrinth",
		"Laughing Cove",
		"Rosberg Bowels",
		"Kerrograve Marsh",
		"Horsware Swamp",
		"The Glades of Atipon",
		"The Mire of Blainswell",
		"The Abyss of Sufdeen"
	],
	MOUNTAIN: [
		"The Dangerous Volcano",
		"The Adamantine Hill",
		"The Prickly Hillside",
		"The Enormous Rise",
		"Gamnora Pinnacle",
		"Tillrane Slopes",
		"Blackdiac Hillside",
		"Calram Bluff",
		"Sufpids Pinnacle",
		"Varencier Bluff",
		"The Southern Highlands",
		"The Towering Slopes",
		"The Windy Highlands",
		"The Mammoth Bluff",
		"Rugcouche Tops",
		"Calsons Pinnacle",
		"Humgonie Peaks",
		"Tolmark Rise",
		"Wallsomin Bluff",
		"Nokolodge Mountains",
		"The Hopeless Bluff",
		"The Ice-Crowned Volcano",
		"The Golden Peaks",
		"The Fabled Peaks",
		"Stannola Heights",
		"Pasdown Highlands",
		"Orovons Rise",
		"Brighboro Tips",
		"Bloomtonas Slopes",
		"Bromcouche Highlands",
		"The Restless Hills",
		"The Jagged Rise",
		"The Relentless Peaks",
		"The Ever Reaching Heights",
		"Bollodge Peaks",
		"Golmeda Tips",
		"Sunderval Mountain",
		"Berkwater Highland",
		"Mensmouth Tops",
		"Rosewin Heights",
		"The Savage Slopes",
		"The Infernal Summit",
		"The Remote Bluff",
		"The Mysterious Tops",
		"Ecklan Bluff",
		"Oxforte Pinnacle",
		"Marlshire Tips",
		"Rowgrave Tips",
		"Hebfail Pinnacle",
		"Causabron Highland",
		"The Hungry Highlands",
		"The White Tips",
		"The Fearsome Slopes",
		"The Frozen Highlands",
		"Corwe Hill",
		"Berthierley Pinnacle",
		"Trayville Heights",
		"Churchgar Mountain",
		"Causabel Peaks",
		"Votwaki Mountains",
		"The Isolated Hills",
		"The Windy Summit",
		"The Gold Peaks",
		"The Ethereal Tips",
		"Davellinet Bluff",
		"Oroguay Peaks",
		"Ganshire Hill",
		"Windnora Highland",
		"Coston Summit",
		"Pacburns Mountains",
		"The Mammoth Hill",
		"The Distant Mountains",
		"The Scarlet Heights",
		"The Slumbering Tips",
		"Farmingforte Bluff",
		"Ridgelinet Volcano",
		"Sunmeda Mountain",
		"Middlescastle Hill",
		"Yarchester Rise",
		"Pelwich Hillside",
		"The Ancient Mountain",
		"The Thundering Hills",
		"The Calmest Peaks",
		"The Laughing Summit",
		"Mataway Pinnacle",
		"Galdown Hill",
		"Leisle Highlands",
		"Bienneau Highlands",
		"Innisdover Highlands",
		"Grafworth Rise",
		"The Monstrous Highland",
		"The Titanic Mountains",
		"The Gigantic Hills",
		"The Whispering Mountain",
		"Plaijour Volcano",
		"Dartdon Hillside",
		"Bolsea Hillside",
		"Norcam Highlands",
		"Gilvista Heights",
		"Gretmiota Tips"
	],
	DESERT: [
		"The Calm Fields",
		"The Dangerous Savanna",
		"The Sterile Fields",
		"The Twisting Steppes",
		"The Waterless Tundra",
		"Dangerous Wilderness",
		"Bare Flatlands",
		"Voiceless Hinterland",
		"Bleak Tundra",
		"Sly Hinterland",
		"The Northern Expanse",
		"The Sly Wilderness",
		"The Yellow Wilds",
		"The Restless Frontier",
		"The Arid Hinterland",
		"Treacherous Savanna",
		"Rocky Fields",
		"Black Tundra",
		"Moaning Wastes",
		"Desolated Fields",
		"The Lightest Badlands",
		"The Dark Wilderness",
		"The Frozen Expanse",
		"The Waterless Wilds",
		"The Restless Savanna",
		"Malevolent Grasslands",
		"Unknown Prairie",
		"Malevolent Barrens",
		"Flat Borderlands",
		"Darkest Wastes",
		"The Enchanted Prairie",
		"The Dry Hinterland",
		"The Dreary Hinterland",
		"The Malicious Wasteland",
		"The Voiceless Wilds",
		"Dreadful Steppes",
		"Southern Wastes",
		"Malevolent Savanna",
		"Calmest Tundra",
		"Treacherous Fields",
		"The Feared Wilds",
		"The Thundering Barrens",
		"The Cursed Fields",
		"The Uninteresting Wilds",
		"The Burning Steppes",
		"Windy Emptiness",
		"Violent Tundra",
		"Twisting Savanna",
		"Southern Expanse",
		"Empty Borderlands",
		"The Bone-Dry Frontier",
		"The Hellish Expanse",
		"The Thundering Expanse",
		"The Neverending Wastes",
		"The Empty Frontier",
		"Malicious Frontier",
		"Painful Frontier",
		"Narrow Prairie",
		"Charmed Badlands",
		"Twisting Emptiness",
		"The Arctic Wasteland",
		"The Hot Tundra",
		"The Quiet Wastes",
		"The Narrow Savanna",
		"The Charmed Flatlands",
		"Mighty Hinterland",
		"Grim Fields",
		"Decayed Savanna",
		"Mighty Frontier",
		"Dangerous Frontier",
		"The Ethereal Expanse",
		"The Scorched Desert",
		"The Eastern Savanna",
		"The Ethereal Frontier",
		"The Scorched Savanna",
		"Scorched Desert",
		"Desolate Flatlands",
		"Mirrored Wilderness",
		"Arctic Desert",
		"Feared Tundra",
		"The Quiet Wastes",
		"The Boiling Frontier",
		"The Windy Emptiness",
		"The Dreaded Wasteland",
		"The Restless Grasslands",
		"Restless Emptiness",
		"Calmest Frontier",
		"Yellow Frontier",
		"Violent Wilderness",
		"Cunning Grasslands",
		"The Mysterious Emptiness",
		"The Haunted Wilderness",
		"The Dehydrated Wasteland",
		"The Red Borderlands",
		"The Unknown Prairie",
		"Dry Frontier",
		"Dreadful Savanna",
		"Lifeless Savanna",
		"Forbidden Wilderness",
		"Soundless Grasslands"
	],
	JUNGLE: [
		"The Rugged Jungle",
		"The Shimmering Rain Forest",
		"The Elephant Tusk Wilderness",
		"The Sterile Jungles",
		"The Misty Gardens",
		"The Orangutan Garden",
		"The Jungle of Lanwagay",
		"Ceeldweyna Jungles",
		"Naila Tropics",
		"Manyale Paradise",
		"The Stormy Jungle",
		"The Tigress Wilds",
		"The Distant Wilds",
		"The Raging Gardens",
		"The Ferocious Tropics",
		"The Peaceful Jungle",
		"The Wilderness of Tayu",
		"Gawak Rain Forest",
		"Abuco Tropics",
		"Tubit Wilds",
		"The Elephant Garden",
		"The Ancient Rain Forest",
		"The Lionroar Jungles",
		"The Sad Wilds",
		"The Scented Jungle",
		"The Wailing Tropics",
		"The Wilds of Yarisia",
		"Balliharro Rain Forest",
		"Kerureria Gardens",
		"Dhajir Rain Forest",
		"The Flower Tropics",
		"The Haunted Paradise",
		"The Blazing Rain Forest",
		"The Wailing Wild",
		"The Moonlit Wilderness",
		"The Rugged Garden",
		"The Wild of Pumdweyne",
		"Buurdsumu Wild",
		"Galzi Bush",
		"Rumasa Garden",
		"The Anaconda Bush",
		"The Emperor Rain Forest",
		"The Baboon Paradise",
		"The Lioness Bush",
		"The Thundering Wilderness",
		"The Thundering Wild",
		"The Wild of Arabraf",
		"Galinvine Jungles",
		"Qortein Wild",
		"Soringo Wilderness",
		"The Voiceless Gardens",
		"The Turbulent Jungle",
		"The Primate Wild",
		"The Crocodile Gardens",
		"The Cougar Paradise",
		"The Spider Tropics",
		"The Garden of Siavasha",
		"Banban Jungle",
		"Gute Rain Forest",
		"Zeisamo Wilderness",
		"The Brutal Gardens",
		"The Lionroar Garden",
		"The Titan Wilderness",
		"The Waking Rain Forest",
		"The Royal Lion Wilds",
		"The Slumbering Gardens",
		"The Jungle of Aver",
		"Raroka Jungles",
		"Jarigema Wilds",
		"Basamo Bush",
		"The Waking Garden",
		"The Moonlit Jungles",
		"The Sleeping Wild",
		"The Windless Wilds",
		"The Scarlet Wilderness",
		"The Scented Bush",
		"The Bush of Colguban",
		"Marsabuur Bush",
		"Kakadagaruen Wilderness",
		"Kiamgale Bush",
		"The Silent Wilds",
		"The Violent Gardens",
		"The Tempest Garden",
		"The Tempest Rain Forest",
		"The Hungry Wild",
		"The White Tiger Wilderness",
		"The Jungles of Garoni",
		"Galhaw Paradise",
		"Kuhaarreey Gardens",
		"Bojabe Wild",
		"The Plain Wild",
		"The Red Garden",
		"The Ocelot Wilderness",
		"The Preying Wilds",
		"The Thornbush Tropics",
		"The Black Rhino Tropics",
		"The Wild of Malalaba",
		"Pumwakayo Gardens",
		"Faramanga Jungle",
		"Kitasumu Gardens"
	]
}

var mouse_cursor: Vector2
var click_cursor: Vector2
var building_popup : PopupMenu
var world_tile_map : TileMap
var world_select : TileMap
var neighbour_mask : TileMap
var world_node : Node2D
var building_scene
var building_flag : bool = false
var lower_bounds : Vector2 = Vector2(0, 0)
var upper_bounds : Vector2 = Vector2(0, 0)
var tile_data : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_cursor = Vector2(0, 0)
	world_tile_map = get_node("WorldTileMap")
	world_select = get_node("WorldSelect")
	neighbour_mask = get_node("NeighbourMask")
	world_node = get_node(NodeMgr.world)
	place_tile(Vector2(0, 0), 0)
	building_scene = load("res://src/UI/BuildingMenu.tscn")
	
func map_to_world(vec : Vector2):
	return world_select.map_to_world(vec)

func _process(delta):
	clear_cursor()
	# This is a hack for nested viewports, see https://github.com/godotengine/godot/issues/32222
	var zoom = get_node(NodeMgr.camera).zoom
	var offset_position = get_tree().current_scene.get_global_mouse_position() - get_viewport_transform().origin
	offset_position *= zoom
	mouse_cursor = world_select.world_to_map(offset_position)
	# END HACK
	if neighbour_mask.get_cellv(mouse_cursor) == 0:
		if world_tile_map.get_cellv(mouse_cursor) == -1:
			place_cursor()
			if Input.is_action_just_pressed("ui_select"):
				if building_flag == false:
					click_cursor = mouse_cursor
					emit_signal("tile_clicked", click_cursor)
					building_flag = true
					var building_menu = building_scene.instance()
					building_menu.position = world_tile_map.map_to_world(click_cursor)
					building_menu.click_cursor = click_cursor
					add_child(building_menu)
func place_cursor():
	world_select.set_cellv(mouse_cursor, 0)
	
func clear_cursor():
	world_select.set_cellv(mouse_cursor, -1)

func place_tile(location: Vector2, tile: int):
	world_tile_map.set_cell(location.x, location.y, 0, false, false, false, Vector2(tile, 0))
	tile_data[location] = get_tile_name(tile)
	if tile == 0:
		world_node.spawn_adventurer(location)
	neighbour_mask.set_cellv(location, 0)
	neighbour_mask.set_cellv(location + Vector2(0, 1), 0)
	neighbour_mask.set_cellv(location + Vector2(0, -1), 0)
	neighbour_mask.set_cellv(location + Vector2(1, 0), 0)
	neighbour_mask.set_cellv(location + Vector2(-1, 0), 0)
	var world_loc = map_to_world(location)
	if world_loc.x < lower_bounds.x:
		lower_bounds.x = world_loc.x
	if world_loc.y < lower_bounds.y:
		lower_bounds.y = world_loc.y
	if world_loc.x > upper_bounds.x:
		upper_bounds.x = world_loc.x
	if world_loc.y > upper_bounds.y:
		upper_bounds.y = world_loc.y

func get_tile_name(tile: int):
	if tile == ARCTIC:
		return "The Cold"
	if tile == ALPINE:
		tile = MOUNTAIN
	if tile == HILLS:
		tile = MOUNTAIN
	return NAMES[tile][randi() % NAMES.size()]
