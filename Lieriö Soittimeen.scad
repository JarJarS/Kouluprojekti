$fn = 120; // Laatu: 120 tekee erittäin sileän pinnan

// --- MITAT (Muokkaa näitä työntömitan mukaan) ---

// Yläosa (Suppilo)
yla_halkaisija = 65;      // Levein kohta ylhäällä
koko_korkeus = 65;        // Koko kappaleen korkeus

// Alaosa (Lieriömäinen kanta)
ala_halkaisija_runko = 30; // Se kohta, josta kartio alkaa
ala_korkeus = 15;          // Koko suoran alaosan pituus (sisältää huulloksen)

// Huullos (Aivan alin osa)
huullos_halkaisija = 29.5; // Hieman kapeampi kuin runko?
huullos_korkeus = 15;       // Huulloksen korkeus

// Seinämät ja pohja
seina = 2;                 // Muovin paksuus
pohjan_paksuus = 2;        // Välipohjan paksuus (erottaa ylä- ja alareiän)

// ------------------------------------------------

difference() {
    
    // 1. ULKOMUOTO (Plussataan osat yhteen)
    union() {
        // A) Huullos (alin osa)
        // Tehdään pieni viiste (d2 > d1), jotta se ohjautuu koloon helpommin
        cylinder(d1 = huullos_halkaisija - 0.5, d2 = huullos_halkaisija, h = huullos_korkeus);
        
        // B) Alaosan runko (suora osa huulloksen päällä)
        translate([0, 0, huullos_korkeus])
        cylinder(d = ala_halkaisija_runko, h = ala_korkeus - huullos_korkeus);
        
        // C) Yläosa (Kartio)
        // Alkaa alaosan päältä ja levenee ylös
        translate([0, 0, ala_korkeus])
        cylinder(d1 = ala_halkaisija_runko, d2 = yla_halkaisija, h = koko_korkeus - ala_korkeus);
    }

    // 2. SISÄMUOTO (Miinustetaan reiät)
    
    // A) Alareikä (Menee alhaalta ylöspäin)
    // Lasketaan reiän syvyys niin, että väliin jää haluttu pohjan paksuus
    // Kuvien perusteella reikä on suora.
    translate([0,0,-0.1]) // Pieni siirto alaspäin, jotta reikä varmasti puhkeaa
    cylinder(d = ala_halkaisija_runko - (seina*2), h = (ala_korkeus) - pohjan_paksuus + 0.1);
    
    // B) Yläreikä (Suppilo)
    // Alkaa välipohjan päältä ja levenee ylös.
    translate([0, 0, ala_korkeus])
    // d1 on alareikä, d2 on yläreikä. Seinät vähennetään molemmista.
    cylinder(d1 = ala_halkaisija_runko - (seina*2), d2 = yla_halkaisija - (seina*2), h = (koko_korkeus - ala_korkeus) + 1);
}
