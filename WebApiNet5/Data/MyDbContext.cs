using Microsoft.EntityFrameworkCore;
namespace WebApiNet5.Data
{
    public class MyDbContext : DbContext
    {
        public MyDbContext(DbContextOptions options) : base(options)
        {
            
        }
        public DbSet<RefreshToken> RefreshTokens { get; set; }
        public DbSet<WebApiNet5.Data.NguoiDung> NguoiDungs { get; set; }
        public DbSet<WebApiNet5.Data.HangHoa> HangHoas { get; set;}
        public DbSet<Loai> Loais { get; set;}

        public DbSet<DonHang> DonHangs { get; set;}
        public DbSet<ChiTietDonHang> ChiTietDonHangs { get; set;}
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DonHang>(entity =>
            {
                entity.ToTable("DonHang");
                entity.HasKey(dh => dh.MaDH);
                entity.Property(dh => dh.NgayDat).HasDefaultValueSql("getutcdate()");
            });
            modelBuilder.Entity<ChiTietDonHang>(entity =>
            {
                entity.ToTable("ChiTietDonHang");
                entity.HasKey(ct => new { ct.MaDH, ct.MaHh });
                entity.HasOne(ct => ct.DonHang)
                      .WithMany(dh => dh.ChiTietDonHang)
                      .HasForeignKey(ct => ct.MaDH)
                      .HasConstraintName("FK_CtDonHang_DonHang");
                entity.HasOne(ct => ct.hangHoa)
                      .WithMany(h => h.ChiTietDonHang)
                      .HasForeignKey(ct => ct.MaHh)
                      .HasConstraintName("FK_CtDonHang_HangHoa");
            });
            modelBuilder.Entity<NguoiDung>(entity =>
            {
                entity.HasIndex(nd => nd.UserName).IsUnique();
                entity.HasIndex(nd => nd.Email).IsUnique();
                entity.Property(nd => nd.Email).IsRequired().HasMaxLength(100);
                entity.Property(nd => nd.Hoten).IsRequired().HasMaxLength(100);
            });
        }
    }
}
