using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(VhiecleWeb.Startup))]
namespace VhiecleWeb
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
