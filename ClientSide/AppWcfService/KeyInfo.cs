using System;

namespace AppWcfService
{
    public class KeyInfo
    {
        public DateTime CreationDate { get; internal set; }
        public int DaysLeft { get; internal set; }
        public bool IsExpired { get; internal set; }
        public bool IsValid { get; internal set; }
        public int SetTime { get; internal set; }
    }
}