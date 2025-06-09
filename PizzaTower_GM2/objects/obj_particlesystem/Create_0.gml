enum particletypes
{
	first = 0,
	cloudeffect = 1,
	crazyrunothereffect = 2,
	highjumpcloud1 = 3,
	highjumpcloud2 = 4,
	jumpdust = 5,
	balloonpop = 6,
	shotgunimpact = 7,
	impact = 8,
	genericpoofeffect = 9,
	keyparticles = 10,
	teleporteffect = 11,
	landcloud = 12,
	ratmountballooncloud = 13,
	groundpoundeffect = 14,
	noisegrounddasheffect = 15,
	antigrav_bubblepop = 16,
	last = 17,
}

enum particle_attributes
{
	normal = 0,
	fade = 1,
}

if (instance_number(obj_particlesystem) > 1)
{
	instance_destroy();
	exit;
}
depth = -99;
global.particle_system = part_system_create();
global.part_map = ds_map_create();
global.part_depth = ds_map_create();
global.part_emitter = part_emitter_create(global.particle_system);
global.debris_list = ds_list_create();
global.collect_list = ds_list_create();
var p = declare_particle(particletypes.cloudeffect, spr_cloudeffect, 0.5, -4);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.crazyrunothereffect, spr_crazyrunothereffect, 0.5, -99);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.highjumpcloud1, spr_highjumpcloud1, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.highjumpcloud2, spr_highjumpcloud2, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.jumpdust, spr_jumpdust, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.balloonpop, spr_balloonpop, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.shotgunimpact, spr_shotgunimpact, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.impact, spr_impact, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.genericpoofeffect, spr_genericpoofeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.antigrav_bubblepop, spr_antigrav_bubblepop, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.keyparticles, spr_keyparticles, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.teleporteffect, spr_teleporteffect, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.landcloud, spr_landcloud, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.noisegrounddasheffect, spr_noisegrounddasheffect, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.ratmountballooncloud, spr_ratmountballooncloud, 0.7, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(particletypes.groundpoundeffect, spr_groundpoundeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
