namespace TransService
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using System.Runtime.Serialization;

    public class TransData : DbContext
    {
        // Your context has been configured to use a 'TransData' connection string from your application's 
        // configuration file (App.config or Web.config). By default, this connection string targets the 
        // 'TransService.TransData' database on your LocalDb instance. 
        // 
        // If you wish to target a different database and/or database provider, modify the 'TransData' 
        // connection string in the application configuration file.
        public TransData()
            : base("name=TransData")
        {
        }

        // Add a DbSet for each entity type that you want to include in your model. For more information 
        // on configuring and using a Code First model, see http://go.microsoft.com/fwlink/?LinkId=390109.

        public virtual DbSet<MyEntity> MyEntities { get; set; }
    }

    [DataContract]
    public class MyEntity
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public string Name { get; set; }
    }
}