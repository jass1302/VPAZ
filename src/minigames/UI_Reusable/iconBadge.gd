extends TextureButton

export (String,
"Seleccionar",
"Mini1",
"Mini2",
"Mini3",
"Mini4",
"Mini5",
"Mini6",
"Mini7",
"Mini8",
"Mini9",
"Mini10",
"badge_0",
"badge_1",
"badge_2",
"badge_3"
) var iconBadge

var gotIt: bool = true

var truePath: String = "res://assets/icons/badges/conseguida/"
var falsePath: String = "res://assets/icons/badges/no_conseguida/"

func _ready():
	setIcons()
	
func setIcons() -> void:
	match iconBadge:
		"badge_0":
			if ProfileManager.obtainedBadges[10]:
				texture_normal = load(truePath + "Introduccion.png")
			else:
				print("a")
				texture_normal = load(falsePath + "Introduccion_gris.png")
		"badge_1":
			if ProfileManager.obtainedBadges[11]:
				texture_normal = load(truePath + "Medalla_Recolector_1.png")
			else:
				texture_normal = load(falsePath + "Medalla_Recolector_1_gris.png")
		"badge_2":
			if ProfileManager.obtainedBadges[12]:
				texture_normal = load(truePath + "Medalla_Recolector_2.png")
			else:
				texture_normal = load(falsePath + "Medalla_Recolector_2_gris.png")
		"badge_3":
			if ProfileManager.obtainedBadges[13]:
				texture_normal = load(truePath + "Medalla_Recolector_3.png")
			else:
				texture_normal = load(falsePath + "Medalla_Recolector_3_gris.png")
		"Mini1":
			if ProfileManager.obtainedBadges[0]:
				texture_normal = load(truePath + "Medalla_Minijuego_1.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_1_gris.png")
		"Mini2":
			if ProfileManager.obtainedBadges[1]:
				texture_normal = load(truePath + "Medalla_Minijuego_2.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_2_gris.png")
		"Mini3":
			if ProfileManager.obtainedBadges[2]:
				texture_normal = load(truePath + "Medalla_Minijuego_3.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_3_gris.png")
		"Mini4":
			if ProfileManager.obtainedBadges[3]:
				texture_normal = load(truePath + "Medalla_Minijuego_4.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_4_gris.png")
		"Mini5":
			if ProfileManager.obtainedBadges[4]:
				texture_normal = load(truePath + "Medalla_Minijuego_5.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_5_gris.png")
		"Mini6":
			if ProfileManager.obtainedBadges[5]:
				texture_normal = load(truePath + "Medalla_Minijuego_6.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_6_gris.png")
		"Mini7":
			if ProfileManager.obtainedBadges[6]:
				texture_normal = load(truePath + "Medalla_Minijuego_7.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_7_gris.png")
		"Mini8":
			if ProfileManager.obtainedBadges[7]:
				texture_normal = load(truePath + "Medalla_Minijuego_8.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_8_gris.png")
		"Mini9":
			if ProfileManager.obtainedBadges[8]:
				texture_normal = load(truePath + "Medalla_Minijuego_9.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_9_gris.png")
		"Mini10":
			if ProfileManager.obtainedBadges[9]:
				texture_normal = load(truePath + "Medalla_Minijuego_10.png")
			else:
				texture_normal = load(falsePath + "Medalla_Minijuego_10_gris.png")
