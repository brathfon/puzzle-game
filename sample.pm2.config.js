module.exports = {
  /**
   * Application configuration section
   * http://pm2.keymetrics.io/docs/usage/application-declaration/
   */
  apps : [

    // First application
    {
      name      : 'pg',
      script    : './bin/www',
      log_date_format : 'YYYY-MM-DD HH:mm:ss',
      env: {
        NODE_ENV: 'development',
        PORT: '3013'
      },
      env_production : {
        NODE_ENV: 'production',
        PORT: '3013',
        DB_HOST: 'localhost',
        DB_USER: 'user',
        DB_USER_PASSWORD: 'pw',
        DB_DATABASE: 'something',
        DB_POOL_SIZE: 50,
        JWT_SECRET: '',
        WEB_MASTER_EMAIL: 'someone@gmail.com',
        PAYPAL_SANDBOX_CREDENTIALS: 'AQAjpL_QO1SFdti6tx7S6ajcIitqQjZiAhpJhRIQNxQ5xgB19-0p8KORtFWL0jel_QgdFUJnrmTZdxBS',
        PAYPAL_PRODUCTION_CREDENTIALS: 'AcVFalzIkIwt2dRZJeSXZNDXyvgZQhju5GQ4333qcX9pGPvuxcG3osPQ2hx3gBpWhilI2t6_a7pn53M_',
        PAYPAL_ENV: 'development',
        SIMULATE_PAYPAL_SANDBOX: 'no'
      }
    },
  ],

  /**
   * Deployment section
   * http://pm2.keymetrics.io/docs/usage/deployment/
   */
  deploy : {
    production : {
      user : 'node',
      host : '212.83.163.1',
      ref  : 'origin/master',
      repo : 'git@github.com:repo.git',
      path : '/var/www/production',
      'post-deploy' : 'npm install && pm2 reload ecosystem.config.js --env production'
    },
    dev : {
      user : 'node',
      host : '212.83.163.1',
      ref  : 'origin/master',
      repo : 'git@github.com:repo.git',
      path : '/var/www/development',
      'post-deploy' : 'npm install && pm2 reload ecosystem.config.js --env dev',
      env  : {
        NODE_ENV: 'dev'
      }
    }
  }
};
