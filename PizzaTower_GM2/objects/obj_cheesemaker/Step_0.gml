if (floor(image_index) == 3 && madecheese == false)
{
	instance_create(x + 32, y + 64, obj_cheeseblob);
	madecheese = true;
}
if (ANIMATION_END)
{
	madecheese = false;
}
