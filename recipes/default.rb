

#install oracle jdk
include_recipe 'java'

include_recipe 'jenkins::master'

include_recipe 'jenks::plugins'



# Create private key credentials
jenkins_private_key_credentials 'localjenks' do
  id          'localjenks'
  description 'github comm'
  private_key "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAko9rx09eYMASht7JdrR3g3Htvu7q559OrWYhHIR4keloWPFIiUc37H5fjvPb
+BRv9pY6/kgdMPJc5pi6L4Y4+pFXWVifBiV9oX9+noKFjPMsk6En92S3gWYT9M0kZkY+/QvNDcPc
74fBhHPOCvo5J55PpMsNMOa6YGXryNuBBrizhFyu1QNfIpcSP9wO5cxNr21EYEoDHN7a49x0+5NM
vOK34tb//iBtdA2qZWs25129hX3ogMZiVKiwbSrd355/h+V/MzPljxN1xt35Z1ljCLlgfIYsH/EM
yasD26eCopK4oEOej8R40lgGECqdzEkqdAcCDQ391HhzjI0QWlww0wIDAQABAoIBAG67hgc05G3d
MSJNuZHCkHnz3llgUoNmTh+dBm9xd1dnLrvksZVnBc3dPX3Yqd4qMt3wa+orukJ9G8vuoN2/X9WR
cpnC54PRV7ZpidVhcF4qbQetv3Cf3DYcVf+j71iGwpiWDfvUfF1OCNx2Urrgi8ZvSmWMNQ85hJ/I
4fkEP9w/Ee4z3qOCam3h945WseRg6Kd709Z/hRFY8e33VdoA1857/C17iPm/nJsLvkLWLUvnuShZ
Nbu+M3eWfgb+fSjVhE1p7GBzFerP0wGl7C+7GCs+Iw4HBROHB/VSTJ5KQWMwZ1eCm7bwfRUgArrO
PDaw6qlkTJdEL+XeXvRjRpnmbqECgYEA3AoltbTNpbRM5swJPGUEs0aSiqJI8gL4eAVnoiErp3lt
0JFAdJwPuL8+rPzlJBNbGTH4r54jjq5TQ+IvgV31mKdTxA71/SmoGKAteD6ubxe67QSuf9H04aba
qcMcSi9U8U9dZrM0KRdEW4I0xO7xNJCKyoV5Ns/J1X86pzOOmEcCgYEAqoMZELRWKVm1/SCS+zok
c6xvS6ZJjZdlx6Yt1FsaugJbRF83wSUY13oDUx1EKkTLdjA6Ts0mUMFvbmrHuN4gskBuW9B4HDtI
7AXdfsBcU815YgNhsn7aDIG+s6NVmTSM6JdDjUiN+XcjAv02+V58SeEspmX4yoX2f1kvnHlFNRUC
gYEAw+mo/6r2evYYjlnWU1aiI7jPGu45QnlQnxQ43ErqYlekZdId8HVPLi/g7wbQQhmVv84VXM/R
WuVtr4BAyc9Nr1g0JdkoPfsL9rkPIwO0LaeUQBouABKBFTSJdiMJGiggWiZOw/UEmR1lOJCqyTjx
u9qCKKVEcn/5dcStBVfLO1sCgYA5iRcSHefc+BqCmVU/VHUsWwkK+8dh8a40Wgyo1T0FevoU7hRA
JiZlvxQUHZH8uU32SXvDT1IYec0B8yIFbV6XB0q1zHha/l4y1h/RP1NoK7NDsWRr+IXXJoiU0Q53
LdZGPZRbvhm6DctQnOTJ7Gn/++03EL2MiPuOKSf5oqoJqQKBgAFVGA6HmWYS5JE0+2D453cBhMGe
5nKoZdP+E2gDjYKeBebfaDzGMNH1SjAOq10FuVw74V1X/Kzcueqguba7L9a7fa7PQXsIl9FY+FnS
MHHTsLCdqfmC0su/lO2boNatczbEEMDhba5LouAWdM+M7UBpJcxuwzwGQhq80fH/CVNa
-----END RSA PRIVATE KEY-----"
end



jenkins_script 'add_authentication' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    import hudson.security.*
    import org.jenkinsci.plugins.*

    def instance = Jenkins.getInstance()
      println "$instance"

    def githubRealm = new GithubSecurityRealm('https://github.com', 'https://api.github.com', '7a17a453ea7fc5785e04', 'a7b8f3c85cb1a258271cc4d3c36477acb0570cef')
      instance.setSecurityRealm(githubRealm)
    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
      instance.setAuthorizationStrategy(strategy)

    instance.save()
  EOH
end
