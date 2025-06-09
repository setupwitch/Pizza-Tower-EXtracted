function cutscene_wait(_time)
{
	timer++;
	if (timer >= _time)
	{
		timer = 0;
		cutscene_end_action();
	}
}
