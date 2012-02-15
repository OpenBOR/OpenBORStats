void randomCreator(int maxEnemy)
{//
// V0.01
// MaxEnemy : Max allowed enemies on stage
    int iEnemyCnt = countaliveenemies(1);
    if (iEnemyCnt <  maxEnemy)
    {
      void enemySpawnName = "devo";
      spawnentity enemySpawnName 0 0 0 0
      decreasehealth 1;
    }

}
