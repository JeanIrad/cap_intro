const { rateLimit, ipKeyGenerator } = require('express-rate-limit');

const PROFILES = {
  IT_Admin: { windowMs: 60_000, max: 300 },
  IT_Viewer: { windowMs: 60_000, max: 120 },
  Employee: { windowMs: 60_000, max: 60 },
  anonymous: { windowMs: 60_000, max: 20 },
};

const limiters = Object.fromEntries(
  Object.entries(PROFILES).map(([role, opts]) => [
    role,
    rateLimit({
      windowMs: opts.windowMs,
      max: opts.max,
      keyGenerator: (req) => {
        if (req.query.apiKey) return req.query.apiKey;
        return ipKeyGenerator(req.ip);
      },
      standardHeaders: true,
      legacyHeaders: false,
      handler: (req, res) => {
        res.status(429).json({
          error: {
            code: '429',
            message:
              `Too many requests. Limit for role '${role}': ` +
              `${opts.max} requests per ${opts.windowMs / 1000}s.`,
          },
        });
      },
    }),
  ]),
);

exports.roleBasedLimiter = async function (req, res, next) {
  const roles = Array.isArray(req.user?.roles)
    ? req.user?.roles
    : Object.keys(req.user?.roles || {});

  let limiter;
  if (roles.includes('IT_Admin')) limiter = limiters.IT_Admin;
  else if (roles.includes('IT_Viewer')) limiter = limiters.IT_Viewer;
  else if (roles.includes('Employee')) limiter = limiters.Employee;
  else limiter = limiters.anonymous;

  console.log('REQUEST STARTS WITH: ', req.path);
  console.log('----------------------');
  console.log('REQUST USER', req.user);
  console.log(req.path.startsWith('/asset-management/'));
  console.log('----------------------');
  if (!req.path.startsWith('/asset-management/')) return next();
  return limiter(req, res, next);
};
