package org.realityforge.glassfish.seam;

import com.sun.appserv.security.ProgrammaticLogin;
import java.io.Serializable;
import javax.inject.Inject;
import org.jboss.seam.security.BaseAuthenticator;
import org.jboss.seam.security.Credentials;
import org.picketlink.idm.api.Credential;
import org.picketlink.idm.impl.api.PasswordCredential;
import org.picketlink.idm.impl.api.model.SimpleUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JaasAuthenticator
  extends BaseAuthenticator
  implements Serializable
{
  private transient final Logger _log = LoggerFactory.getLogger( getClass() );

  @Inject
  private Credentials _credentials;

  public void authenticate()
  {
    final String username = _credentials.getUsername();
    final Credential credential = _credentials.getCredential();
    if ( null == username || !( credential instanceof PasswordCredential ) )
    {
      setStatus( AuthenticationStatus.FAILURE );
      _log.info( "Login for user (" + username + ") failed: unsupported username/credential." );
      return;
    }
    final PasswordCredential passwordCredential = (PasswordCredential) credential;
    final ProgrammaticLogin login = new ProgrammaticLogin();
    boolean success;
    try
    {
      success = login.login( username, passwordCredential.getValue(), "s", true );
    }
    catch ( final Exception e )
    {
      success = false;
    }
    if ( !success )
    {
      setStatus( AuthenticationStatus.FAILURE );
      _log.info( "Login for user (" + username + ") failed: wrong username/password." );
      return;
    }
    setStatus( AuthenticationStatus.SUCCESS );
    setUser( new SimpleUser( username ) );
    _log.info( "Login for user (" + username + ") succeeded." );
  }
}